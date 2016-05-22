package template;

import template.utils.mobile.AppRating;
import template.utils.debug.DebugInfo;
import haxe.Timer;
import openfl.net.URLRequest;
import openfl.Lib;
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
//		https://play.google.com/store/apps/details?id=com.rovio.angrybirds
//		var url:String = 'https://play.google.com/store/apps/details?id=com.rovio.angrybirds';

		Timer.delay(function() {
			AppRating.request();
		}, 5000);

		#if showdebuginfo
		var debugInfo:DebugInfo = new DebugInfo();
		addChild(debugInfo);
		#end
	}
}
