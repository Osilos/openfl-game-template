package template;

import haxe.Timer;
import extension.admob.GravityMode;
import extension.admob.AdMob;
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

//		AdMob.enableTestingAds();
//		AdMob.initIOS('ca-app-pub-4254723393059263/3604002133', 'ca-app-pub-4254723393059263/1164592937', GravityMode.BOTTOM);
//		AdMob.showBanner();
//
//		Timer.delay(function () {
//			trace('will show !');
//		}, 4000);
//
//		Timer.delay(function () {
//			AdMob.showInterstitial(0);
//		}, 5000);


		#if showdebuginfo
		var debugInfo:DebugInfo = new DebugInfo();
		addChild(debugInfo);
		#end
	}
}
