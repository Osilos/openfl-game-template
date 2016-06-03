package template;

import template.utils.game.StateObject;
import template.utils.screen.Screen;
import template.utils.screen.const.ScreenPositions;
import template.utils.multiscreen.MultiScreenBuilder;
import String;
import openfl.geom.Point;
import hypsystem.net.NetworkInfos;
import hypsystem.system.Device;
import template.utils.game.GameObject;
import template.utils.mobile.AppSharing;
import haxe.Timer;
import template.utils.mobile.AppRating;
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

	var coins:Array<GameObject> = new Array<GameObject>();

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

//		Debug.addDebugTextAt(new Point(150, 150),
//			Device.getLanguageCode() + '\n' +
//			Device.getName() + '\n'
//			Device.getSystemVersion() + '\n' +
//			Device.isTablet() + '\n' +
//			Device.getUuid() + '\n' +
//			Device.getScaleFactor() + '\n' +
//			NetworkInfos.getConnectionType() + '\n' +
//			NetworkInfos.isConnected() + '\n' +
//			NetworkInfos.isWifi()
//		);



		#if showdebuginfo
		var debugInfo:DebugInfo = new DebugInfo();
		addChild(debugInfo);
		#end
	}
}
