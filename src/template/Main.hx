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

		Sound.playMusic('music');
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}
}
