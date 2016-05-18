package template.utils.screen;
import flash.media.Video;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Lib;
import template.utils.game.GameObject;

/**
 * ...
 * @author Flavien
 */
class Screen
{
	public static function getPositionBy(positionType:Point) : Point {
		var screenSize:Point = getScreenSize();
		
		var position:Point = new Point(screenSize.x / 2, screenSize.y / 2);
		
		position.setTo(
			position.x + position.x * positionType.x,
			position.y + position.y * positionType.y
		);
		
		return position;
	}
	
	public static function getTargetScale(scaleType:Point, target:Sprite) : Point {
		var screenSize:Point = getScreenSize();
		var targetOriginalSize:Point = new Point(
			target.width / target.scaleX, 
			target.height / target.scaleY );
		
		var scaleX:Float = (screenSize.x / targetOriginalSize.x) * scaleType.x;
		var scaleY:Float = (screenSize.y / targetOriginalSize.y) * scaleType.y;
		
		scaleX = scaleX == 0 ? 1 : scaleX;
		scaleY = scaleY == 0 ? 1 : scaleY;
		
		return new Point(scaleX, scaleY);
	}
	
	private static function getScreenSize () : Point {
		return new Point(
			Lib.current.stage.width,
			Lib.current.stage.height
		);
	}
}