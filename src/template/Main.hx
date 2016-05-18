package template;

import pixi.core.display.Container;
import template.utils.game.Containers;
import template.utils.debug.DebugInfo;
import template.utils.debug.Debug;
import openfl.events.Event;
import template.game.Game;
import template.utils.debug.DebugInfo;
import template.utils.localization.Localization;
import template.utils.metadata.Metadatas;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite {
	public function new() {
		super();

		Containers.createContainers();
		Debug.initDefaultContainer(Containers.debug);
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
