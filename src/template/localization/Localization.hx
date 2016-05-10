package src.template.localization;

import haxe.Json;
import Reflect;
import haxe.Json;

#if macro 
	import sys.io.File;
	import sys.FileSystem;
#end

/**
 * ...
 * @author Flavien
 */
class Localization
{
	private static var localizationSource:Map<String, Map<String, Dynamic>> = new Map<String, Map<String, Dynamic>> ();
	
	private static var language:String;
	private static var localizationPath:String = "localization/";
	
	
	/**
	 * Init the localization source
	 */
	public static function init () : Void {
		var jsonSources:String = Localization.getLocalizationSources();
		trace(Json.parse(jsonSources));
		
	}
	
	macro public static function getLocalizationSources() {
		var sources:Dynamic = {};
		var sourcesStringified;

		for (lang in FileSystem.readDirectory("assets/localization/")) {
			if (Reflect.field(sources, lang) == null) {
				Reflect.setField(sources, lang, {});
			}
			for (json in FileSystem.readDirectory("assets/localization/" + lang)) {
				var keyValue = File.getContent("assets/localization/" + lang +"/" + json);
				Reflect.setField(Reflect.field(sources, lang), json, keyValue);
			}
		}

		sourcesStringified = Json.stringify(sources);
		
		return macro $v{sourcesStringified};
	}
	
	/**
	 * Set the language of localization
	 * @param	language
	 */
	public static function changeSelectLanguage(language:String) : Void {
		language = Localization.language;
	}
	
	
	
}