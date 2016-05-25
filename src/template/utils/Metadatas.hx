package template.utils;

import template.utils.config.ApplicationDef;
import Reflect;
import haxe.Json;
import openfl.Assets;

class Metadatas {
	private static inline var APPLICATION_PATH = 'config/application.json';
	private static inline var DATA_SOUND_PATH = 'sounds/sounds.json';

	public static var application:ApplicationDef;
	public static var sound:Map<String, Float> = new Map<String, Float>();

	public function new() {
	}

	public static function load():Void {
		initApplication();
		initSound();
	}

	private static function initApplication():Void {
		var applicationData:String = Assets.getText(APPLICATION_PATH);
		application = Json.parse(applicationData);
	}

	private static function initSound():Void {
		var datas:String = Assets.getText(DATA_SOUND_PATH);
		var datasParsed:Dynamic = Json.parse(datas);

		for (dataParsedField in Reflect.fields(datasParsed)) {
			sound[dataParsedField] = Reflect.field(datasParsed, dataParsedField);
		}
	}
}
