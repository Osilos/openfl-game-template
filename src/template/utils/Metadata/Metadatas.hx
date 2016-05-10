package template.utils.metadata;

import Std;
import Reflect;
import haxe.Json;
import openfl.Assets;
class Metadatas {
	private static inline var DATA_SOUND_PATH = 'sounds/sounds.json';

	public static var sound:Map<String, Float> = new Map<String, Float>();

	public function new() {
	}

	public static function load():Void {
		initSound();
	}

	private static function initSound():Void {
		var datas:String = Assets.getText(DATA_SOUND_PATH);
		var datasParsed:Dynamic = Json.parse(datas);

		for (dataParsedField in Reflect.fields(datasParsed)) {
			sound[dataParsedField] = Reflect.field(datasParsed, dataParsedField);
		}
	}
}
