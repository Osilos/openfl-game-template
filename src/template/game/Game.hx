package template.game;

import template.utils.MathUtils;
import openfl.geom.Point;
import template.utils.screen.const.ScreenPositions;
import template.utils.screen.Screen;
import template.utils.multiscreen.MultiScreenBuilder;
import template.utils.game.Containers;
import template.utils.game.GameObject;

class Game {
	private static var coins:Array<GameObject> = new Array<GameObject>();
	private static var coinsDirection:Array<Point> = new Array<Point>();
	private static var speed:Float = 1;

	public static function start():Void {
		createCoin();
	}

	public static function gameloop(event:Dynamic):Void {

	}

	private static function createCoin():Void {
		var coin:GameObject = new GameObject('portraitUi', 'objecttest');
		var screenCenter:Point = Screen.getPositionAt(ScreenPositions.CENTER);

		MultiScreenBuilder.create()
		.withTargetToHandle(coin)
		.withUsingSafeZoneScaling(true)
		.build();

		coin.x = screenCenter.x;
		coin.y = screenCenter.y;

		Containers.game.addChild(coin);
		coins.push(coin);
		coinsDirection.push(getRandomDirection());
	}

	private static function getRandomDirection():Void {
		return new Point(
			MathUtils.getRandomNumberBetween(-1, 1),
			MathUtils.getRandomNumberBetween(-1, 1)
		);
	}
}
