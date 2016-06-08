package template.game;

import openfl.Lib;
import openfl.display.Tile;
import template.utils.game.Containers;
import openfl.display.Tilemap;
import openfl.display.TilemapLayer;
import openfl.display.Tileset;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.display.DisplayObjectContainer;
import openfl.text.TextField;
import haxe.Timer;
import template.utils.MathUtils;
import openfl.geom.Point;
import template.utils.screen.const.ScreenPositions;
import template.utils.screen.Screen;
import template.utils.multiscreen.MultiScreenBuilder;
import template.utils.game.Containers;
import template.utils.game.GameObject;

class Game {
//	private static var coins:Array<GameObject> = new Array<GameObject>();
	private static var coins:Array<Tile> = new Array<Tile>();
//	private static var coins:Array<MovieClip> = new Array<MovieClip>();
//	private static var coins:Array<Sprite> = new Array<Sprite>();
	private static var coinsDirection:Array<Point> = new Array<Point>();
	private static var delayBeforeCreatingCoin:Int = 30;
	private static var speed:Float = 5;
	private static var coinCount:Int = 0;
	private static var coinCountTextfield:TextField;

	public static function start():Void {
		coinCountTextfield = createCoinCountTextfield();
		for (i in 0...15) {
			createCoin();
		}
	}

	public static function gameloop(event:Dynamic):Void {
		moveCoins();
	}

	private static function createCoin():Void {
//		var coin:GameObject = new GameObject('portraitUi', 'coin_gold');

		var bitmapData:BitmapData = Assets.getBitmapData ("swf/image.png");
		var tileset:Tileset = new Tileset(bitmapData);
		tileset.addRect(bitmapData.rect);
		var layer:TilemapLayer = new TilemapLayer(tileset);
		var tilemap:Tilemap = new Tilemap(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		tilemap.addLayer(layer);
		Containers.game.addChild(tilemap);
		var coin:Tile = new Tile();
		//tilemap.rotation = 38;

//		var coin = new Sprite();
//		var coin:MovieClip = Assets.getMovieClip('portraitUi:coin_gold');
		//coin.cacheAsBitmap = true;
//		coin.gotoAndStop(0);
		//var screenCenter:Point = Screen.getPositionAt(ScreenPositions.CENTER);

//		coin.graphics.beginFill(0x00FF00);
//		coin.graphics.drawCircle(0, 0, 15);

		coin.x = 1000;
		coin.y = 500;

		layer.addTile(coin);

		coins.push(coin);
		coinsDirection.push(getRandomDirection());
		coinCount++;
		coinCountTextfield.text = Std.string(coinCount);

		Timer.delay(function () {
			createCoin();
		}, delayBeforeCreatingCoin);
	}

	private static function getRandomDirection():Point {
		var direction:Point = new Point(
			MathUtils.getRandomNumberBetween(-1, 1),
			MathUtils.getRandomNumberBetween(-1, 1)
		);
		direction.normalize(1);
		return direction;
	}

	private static function moveCoins():Void {
		for (i in 0...coins.length) {
			var coin:Tile = coins[i];
//			var coin:GameObject = coins[i];
//			var coin:MovieClip = coins[i];
//			var coin:Sprite = coins[i];
			var direction:Point = coinsDirection[i];

			coin.x += speed * direction.x;
			coin.y += speed * direction.y;
		}
	}

	private static function createCoinCountTextfield():TextField {
		var textField = new TextField();
		textField.selectable = false;
		textField.defaultTextFormat = new TextFormat("_sans", 12, 0xFF0000);
		textField.x = 50;
		textField.y = 50;
		textField.text = '...';
		textField.width = 9999;
		Containers.game.addChild(textField);
		return textField;
	}
}
