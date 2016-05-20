package template;

import template.utils.game.Containers;
import template.utils.Localization;
import template.utils.multiscreen.MultiScreenBuilder;
import template.utils.screen.const.ScreenPositions;
import openfl.Assets;
import openfl.display.MovieClip;
import openfl.display.Sprite;
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
		Containers.game.addChild(test);

		var test2:MovieClip = Assets.getMovieClip('portrait-template:test');
		Containers.game.addChild(test2);

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
