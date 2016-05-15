package template.utils.sound;

import template.utils.metadata.Metadatas;
import openfl.media.SoundTransform;
import openfl.media.SoundChannel;
import openfl.Assets;

class Sound {
	private inline static var SOUND_EXTENSION:String = "ogg";
	private inline static var SOUND_PATH:String = "sounds";
	private inline static var MUSIC_PATH:String = "musics";
	private inline static var SFX_PATH:String = "sfxs";

	private static var currentMusicPlaying:SoundChannel;
	private static var lastPlayedMusicName:String;
	private static var isMusicMuted:Bool = false;
	private static var isSfxMuted:Bool = false;

	public function new() {
	}

	public static function muteMusic():Void {
		isMusicMuted = true;
		if (currentMusicPlaying != null) {
			currentMusicPlaying.stop();
		}
	}

	public static function unmuteMusic():Void {
		isMusicMuted = false;
		if (lastPlayedMusicName != null) {
			playMusic(lastPlayedMusicName);
		}
	}

	public static function muteSfx():Void {
		isSfxMuted = true;
	}

	public static function unmuteSfx():Void {
		isSfxMuted = false;
	}

	public static function playMusic(name:String, loop:Bool = true):SoundChannel {
		if (!isMusicMuted) {
			lastPlayedMusicName = name;
			if (currentMusicPlaying != null) {
				currentMusicPlaying.stop();
			}
			currentMusicPlaying = play(name, loop, MUSIC_PATH);
			return currentMusicPlaying;
		}
		return null;
	}

	public static function playSfx(name:String, loop:Bool = false):SoundChannel {
		if (!isSfxMuted) {
			return play(name, loop, SFX_PATH);
		}
		return null;
	}

	private static function play(name:String, loop:Bool, typePath:String):SoundChannel {
		var sound:openfl.media.Sound = Assets.getSound(SOUND_PATH + '/' + typePath + '/' + name + '.' + SOUND_EXTENSION);

		if (sound == null) {
			throw soundNotFoundExeption();
		}

		var channel:SoundChannel = sound.play();
		var soundLevel:Float = Metadatas.sound[name];
		channel.soundTransform = new SoundTransform(soundLevel);

		return channel;
	}

	private static function soundNotFoundExeption():String {
		return 'Sound.hx: sound name does not exist';
	}
}
