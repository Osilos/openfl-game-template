package template;

import haxe.Timer;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import template.game.Game;
import template.utils.game.AlignMode;
import template.utils.game.ResizeComponent;
import template.utils.debug.Debug;
import template.utils.debug.DebugInfo;
import template.utils.game.ScaleMode;
import template.utils.metadata.Metadatas;

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
		
		#if showdebuginfo
			var debugInfo:DebugInfo = new DebugInfo();
			addChild(debugInfo);
		#end
	}
}
