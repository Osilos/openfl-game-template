package template;

import pixi.core.display.Container;
import template.utils.game.Containers;
import template.utils.debug.DebugInfo;
import template.utils.debug.Debug;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.ui.Mouse;
import template.game.Game;
import template.utils.game.GameObject;
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
		
		#if !html5 
			Localization.init();
		#end
		
		Metadatas.load();
		Game.start();

		// todo : move to Game.hx when we have GameStage
		#if showdebuginfo
			var debugInfo:DebugInfo = new DebugInfo();
			addChild(debugInfo);
		#end
	}
}
