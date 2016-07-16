package template.game;

import haxe.Timer;
import template.utils.debug.Debug;
import template.utils.screen.Screen;
import openfl.geom.Point;
import template.utils.screen.const.ScreenPositions;
import template.utils.multiscreen.MultiScreenBuilder;
import template.utils.game.Containers;
import template.utils.game.GameObject;

class Game {
	public static function start():Void {
		var multiScreenBuilder:MultiScreenBuilder = MultiScreenBuilder.create()
															   .withUsingSafeZoneScaling(true)
															   .withPlacementPosition(ScreenPositions.CENTER);

		var background:GameObject = new GameObject('portraitUi', 'screenportrait2048', multiScreenBuilder);
		Containers.game.addChild(background);

		var square:GameObject = new GameObject('portraitUi', 'object');
		var position:Point = Screen.getPositionAt(ScreenPositions.CENTER);
		square.x = position.x;
		square.y = position.y;
		Containers.game.addChild(square);

		Debug.addDebugPointAt(position);
	}

	public static function gameloop(event:Dynamic):Void {
		
	}
}
