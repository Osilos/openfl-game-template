package template.utils;

import openfl.media.SoundTransform;
import openfl.media.SoundChannel;
import openfl.Assets;

class Sound {
	private inline static var SOUND_EXTENSION:String = "ogg";
	private inline static var SOUND_PATH:String = "sounds";
	private inline static var MUSIC_PATH:String = "musics";
	private inline static var SFX_PATH:String = "sfxs";

	private static var isMusicMuted:Bool = false;
	private static var isSfxMuted:Bool = false;

	public function new() {
	}

	public static function muteMusic():Void {
		isMusicMuted = false;
	}

	public static function unmuteMusic():Void {
		isMusicMuted = true;
	}

	public static function muteSfx():Void {
		isSfxMuted = true;
	}

	public static function unmuteSfx():Void {
		isSfxMuted = false;
	}

	public static function playMusic(name:String):Void {
		if (!isMusicMuted) {
			play(name, MUSIC_PATH);
		}
	}

	public static function playSfx(name:String):Void {
		if (!isSfxMuted) {
			play(name, SFX_PATH);
		}
	}

	private static function play(name:String, typePath:String):Void {
		var sound:openfl.media.Sound = Assets.getSound(SOUND_PATH + '/' + typePath + '/' + name + '.' + SOUND_EXTENSION);

		if (sound == null) {
			throwSoundNotFoundExeption();
		}

		var channel:SoundChannel = sound.play();
		// todo change volume in according to json sounds
		channel.soundTransform = new SoundTransform(1);
	}

	private static function throwSoundNotFoundExeption():Void {
		throw 'Sound.hx: sound name does not exist';
	}
}
