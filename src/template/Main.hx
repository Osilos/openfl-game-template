package template;

import template.utils.Sound;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	public function new() {
		super();

		untyped window.t = Sound.playMusic;
		untyped window.mute = Sound.muteMusic;
		untyped window.unmute = Sound.unmuteMusic;
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}
}
