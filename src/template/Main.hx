package template;

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
	
	private static var instance:Main;
	
	public static function getInstance () : Main {
		return instance;
	}
	
	public function new() {
		super();

		instance = this;
		
		Debug.initDefaultContainer(this); //todo : create debug container
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
