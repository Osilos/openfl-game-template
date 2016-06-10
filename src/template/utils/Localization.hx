package template.utils;

import openfl.geom.Point;
import haxe.Json;
import Reflect;

#if macro
import sys.io.File;
import sys.FileSystem;
#else
import hypsystem.system.Device;
#end

/**
 * ...
 * @author Flavien
 */
class Localization {
	private static var localizationSource:Map<String, Map<String, Dynamic>> = new Map<String, Map<String, Dynamic>> ();

	private static inline var DEFAULT_LABEL:String = 'TEXT NOT FOUND';
	private static inline var DEFAULT_LANGUAGE:String = 'en';
	private static var language:String;

	/**
	 * Init the localization source
	 */
	public static function init():Void {
		parseSource();
		changeSelectLanguage(getDeviceLang());
	}

	/**
	 * Set the language of localization
	 * @param	language
	 */

	public static function changeSelectLanguage(language:String):Void {
		Localization.language = language;
	}

	/**
	 * Get text source from label
	 * @param	label 
	 * @return source of label
	 * @default return label if source do not exists
	 */

	public static function getText(label:String):String {
		var languageToUse:String = language;

		if (!localizationSource.exists(language)) {
			languageToUse = DEFAULT_LANGUAGE;
			trace("Localization : langage " + language + " does not exist, fallback to " + DEFAULT_LANGUAGE);
		}

		for (source in localizationSource.get(languageToUse)) {
			if (Reflect.hasField(source, label))
				return Reflect.field(source, label);
		}

		trace("Localization : get Text, try to access label do not exists");

		return DEFAULT_LABEL;
	}

	private static function parseSource():Void {
		var sources:String = Localization.getLocalizationSources();
		var parsedSources:Dynamic = Json.parse(sources);

		for (lang in Reflect.fields(parsedSources)) {
			localizationSource.set(lang, new Map<String, Dynamic>());
			for (json in Reflect.fields(Reflect.field(parsedSources, lang))) {
				localizationSource.get(lang)
				.set(json, Json.parse(Reflect.field(Reflect.field(parsedSources, lang), json)));
			}
		}
	}

	private static function getDeviceLang():String {
		#if !macro
		return Device.getLanguageCode().substr(0, 2);
		#else
		return DEFAULT_LANGUAGE;
		#end
	}

	macro public static function getLocalizationSources():Dynamic {
		var sources:Dynamic = {};
		var sourcesStringified;
		var baseDirectory = '';

		#if ios
			baseDirectory = '../';
		#end

		for (lang in FileSystem.readDirectory(baseDirectory + "assets/localization/")) {
			if (Reflect.field(sources, lang) == null) {
				Reflect.setField(sources, lang, {});
			}
			for (json in FileSystem.readDirectory(baseDirectory + "assets/localization/" + lang)) {
				var keyValue = File.getContent(baseDirectory + "assets/localization/" + lang + "/" + json);
				Reflect.setField(Reflect.field(sources, lang), json, keyValue);
			}
		}

		sourcesStringified = Json.stringify(sources);

		return macro $v{sourcesStringified};
	}
}