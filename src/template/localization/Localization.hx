package src.template.localization;
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
		parseSource();
		
	}
	
	private static function parseSource () : Void {
		var jsonSources:String = Localization.getLocalizationSources();
		var sources:Json = Json.parse(jsonSources);
		
		for (lang in Reflect.fields(sources)) {
			localizationSource.set(lang, new Map<String, Dynamic>());
			for (json in Reflect.fields(Reflect.field(sources, lang))) {
				localizationSource.get(lang)
					.set(json, Reflect.field(Reflect.field(sources, lang), json));
			}
		}
		
		trace (localizationSource);
	}
	
	macro public static function getLocalizationSources() {
		var sources:String =  '{';
		
		var comaLang:Bool = false;
		var comaJson:Bool = false;
		
		for (lang in FileSystem.readDirectory("assets/localization/")) {
			if (comaLang) {
				sources += ',';
			}
			comaLang = true;
			
			sources += '"' + lang + '":{';
			
			for (json in FileSystem.readDirectory("assets/localization/" + lang)) {
				if (comaJson) {
					sources += ',';
				}
				comaJson = true;
				
				sources += '"' + json + '":';
				sources += File.getContent("assets/localization/" + lang +"/" + json);				
			}
			sources += "}";	
			comaJson = false;
		}
		
		sources += '}';
		
		return macro $v{sources};
	}
	
	/**
	 * Set the language of localization
	 * @param	language
	 */
	public static function changeSelectLanguage(language:String) : Void {
		language = Localization.language;
	}
	
	public static function getText(label:String) : String {
		return null;
	}
	
	
}