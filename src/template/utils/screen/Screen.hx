package template.utils.screen;

import openfl.display.DisplayObject;
import openfl.geom.Point;
import template.utils.screen.const.ScreenFitsType;
import template.utils.screen.const.ScreenPositions;
import openfl.Lib;

class Screen {
	public static function getPositionAt(normalizedPosition:ScreenPositions):Point {
		var screenSize:Point = getScreenSize();
		var position:Point = new Point(screenSize.x / 2, screenSize.y / 2);

		if (Math.abs(normalizedPosition.x) > 1 || Math.abs(normalizedPosition.y) > 1) {
			throw positionOutOfRangeException();
		}

		position.setTo(position.x + position.x * normalizedPosition.x, position.y + position.y * normalizedPosition.y);

		return position;
	}

	public static function getTargetFitScaleType(fitType:ScreenFitsType, target:DisplayObject):Point {
		var screenSize:Point = getScreenSize();
		var targetOriginalSize:Point = new Point(target.width / target.scaleX, target.height / target.scaleY );

		var scaleX:Float = (screenSize.x / targetOriginalSize.x) * fitType.x;
		var scaleY:Float = (screenSize.y / targetOriginalSize.y) * fitType.y;

		scaleX = scaleX == 0 ? 1 : scaleX;
		scaleY = scaleY == 0 ? 1 : scaleY;

		return new Point(scaleX, scaleY);
	}

	public static function getSafeZoneScale(safeZoneSize:Point):Float {
		var screenSize:Point = getScreenSize();
		var safeZoneRatio:Point = new Point(screenSize.x / safeZoneSize.x, screenSize.y / safeZoneSize.y);
		return Math.min(safeZoneRatio.x, safeZoneRatio.y);
	}

	private static function getScreenSize():Point {
		return new Point(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
	}

	private static function positionOutOfRangeException():String {
		return 'Screen.hx : position parameter value is incorrect (must be between -1, 1)';
	}
}