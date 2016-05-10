package template;

import openfl.events.Event;
import template.game.Game;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	public function new() {
		super();

		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		Game.start();
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
	}

}
