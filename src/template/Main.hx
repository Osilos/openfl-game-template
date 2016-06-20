package template;

import openfl.system.Capabilities;
import openfl.display.StageDisplayState;
import openfl.Lib;
import haxe.Timer;
import template.utils.debug.DebugInfo;
import template.utils.game.Containers;
import template.utils.Localization;
import openfl.display.Sprite;
import template.utils.debug.Debug;
import openfl.events.Event;
import template.game.Game;
import template.utils.Metadatas;

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

		#if showdebuginfo
		var debugInfo:DebugInfo = new DebugInfo();
		addChild(debugInfo);
		#end
	}
}
