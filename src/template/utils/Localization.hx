package template.utils;

import haxe.Json;
import Reflect;

#if macro
import sys.io.File;
import sys.FileSystem;
#end

/**
 * ...
 * @author Flavien
 */
class Localization {private static var localizationSource:Map<String, Map<String, Dynamic>> = new Map<String, Map<String, Dynamic>> ();

	private static var language:String;

	/**
	 * Init the localization source
	 */

	public static function init():Void {
		parseSource();
		// TO DO get language from Device language/config file
		// FallBack to "en" language if don't find
		changeSelectLanguage("en");

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

		for (source in localizationSource.get(language)) {
			if (Reflect.hasField(source, label))
				return Reflect.field(source, label);
		}

		trace("Localization : get Text, try to access label do not exists");

		return label;
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