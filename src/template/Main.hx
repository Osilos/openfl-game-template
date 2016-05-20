package template;

import template.utils.multiscreen.MultiScreenBuilder;
import template.utils.screen.const.ScreenFitsType;
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
		var test:MovieClip = Assets.getMovieClip('portrait-template:screenportrait2048');
		addChild(test);

		MultiScreenBuilder.create()
						  .withTargetToHandle(test)
						  .withPlacementPosition(ScreenPositions.CENTER)
						  .withUsingSafeZoneScaling(true)
						  .build();

		#if showdebuginfo
		var debugInfo:DebugInfo = new DebugInfo();
		addChild(debugInfo);
		#end
	}
}
