package template.utils;

import template.utils.config.ConfigurationDef;
import Reflect;
import haxe.Json;
import openfl.Assets;

class Metadatas {
	private static inline var CONFIGURATION_PATH = 'config/configuration.json';
	private static inline var DATA_SOUND_PATH = 'sounds/sounds.json';

	public static var configuration:ConfigurationDef;
	public static var sound:Map<String, Float> = new Map<String, Float>();

	public function new() {
	}

	public static function load():Void {
		loadConfiguration();
		loadSound();
	}

	private static function loadConfiguration():Void {
		var configurationData:String = Assets.getText(CONFIGURATION_PATH);
		configuration = Json.parse(configurationData);
	}

	private static function loadSound():Void {
		var datas:String = Assets.getText(DATA_SOUND_PATH);
		var datasParsed:Dynamic = Json.parse(datas);

		for (dataParsedField in Reflect.fields(datasParsed)) {
			sound[dataParsedField] = Reflect.field(datasParsed, dataParsedField);
		}
	}
}
