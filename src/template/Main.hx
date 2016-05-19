package template;

import template.utils.screen.const.ScreenFits;
import openfl.geom.Point;
import template.utils.screen.const.ScreenPositions;
import template.utils.screen.Screen;
import openfl.Assets;
import openfl.display.MovieClip;
import template.utils.localization.Localization;
import openfl.display.Sprite;
import template.utils.game.Containers;
import template.utils.debug.DebugInfo;
import template.utils.debug.Debug;
import openfl.events.Event;
import template.game.Game;
import template.utils.metadata.Metadatas;

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
		var test:MovieClip = Assets.getMovieClip('portrait-template:test');

		var scale:Float = Screen.getSafeZoneScale();
		addChild(test);
		trace(scale);
		test.scaleX = scale;
		test.scaleY = scale;
		test.x = Screen.getPositionAt(ScreenPositions.CENTER).x;
		test.y = Screen.getPositionAt(ScreenPositions.CENTER).y;

		#if showdebuginfo
		var debugInfo:DebugInfo = new DebugInfo();
		addChild(debugInfo);
		#end
	}
}
