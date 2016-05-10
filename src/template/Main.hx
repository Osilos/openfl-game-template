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

		Game.start();
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
	}

}
