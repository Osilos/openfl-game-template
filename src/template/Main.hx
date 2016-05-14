package template;

import template.utils.debug.DebugInfo;
import template.utils.debug.Debug;
import openfl.events.Event;
import template.game.Game;
import template.utils.metadata.Metadatas;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite {
	public function new() {
		super();

		Debug.initDefaultContainer(this); //todo : create debug container
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
		Metadatas.load();
		Game.start();

		// todo : move to Game.hx when we have GameStage
		#if showdebuginfo
			var debugInfo:DebugInfo = new DebugInfo();
			addChild(debugInfo);
		#end
	}
}
