package template;

import js.html.AnimationPlayer;
import openfl.Assets;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.MouseEvent;

import openfl.geom.Point;

import openfl.geom.Rectangle;
import openfl.ui.Mouse;
import template.game.Game;
import template.utils.game.GameObject;
import template.utils.metadata.Metadatas;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	private var clip:GameObject;
	
	public function new() {
		super();
		
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
		Metadatas.load();
		Game.start();
		
	}
}
