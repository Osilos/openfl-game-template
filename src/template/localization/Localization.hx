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
		var jsonSources:String = Localization.getLocalizationSources();
		trace(Json.parse(jsonSources));
		
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
	
	
	
}