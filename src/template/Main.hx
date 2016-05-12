package template;

import openfl.geom.Point;
import template.utils.debug.Debug;
import openfl.events.Event;
import template.game.Game;
import template.utils.metadata.Metadatas;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	public function new() {
		super();

		Debug.initContainer(this); //todo : create debug container
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
		Metadatas.load();
		Game.start();
	}
}
