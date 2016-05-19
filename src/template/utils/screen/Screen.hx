package template.utils.screen;

import openfl.geom.Point;
import template.utils.screen.const.ScreenFits;
import template.utils.screen.const.ScreenPositions;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Flavien
 */
class Screen {public static function getPositionAt(normalizedPosition:ScreenPositions):Point {
	var screenSize:Point = getScreenSize();
	var position:Point = new Point(screenSize.x / 2, screenSize.y / 2);

	if (Math.abs(normalizedPosition.x) > 1 || Math.abs(normalizedPosition.y) > 1) {
		throw positionOutOfRangeException();
	}

	position.setTo(position.x + position.x * normalizedPosition.x, position.y + position.y * normalizedPosition.y);

	return position;
}

	public static function getTargetScaleToFit(fitCoef:ScreenFits, target:Sprite):Point {
		var screenSize:Point = getScreenSize();
		var targetOriginalSize:Point = new Point(target.width / target.scaleX, target.height / target.scaleY );

		var scaleX:Float = (screenSize.x / targetOriginalSize.x) * fitCoef.x;
		var scaleY:Float = (screenSize.y / targetOriginalSize.y) * fitCoef.y;

		scaleX = scaleX == 0 ? 1 : scaleX;
		scaleY = scaleY == 0 ? 1 : scaleY;

		return new Point(scaleX, scaleY);
	}

	public static function getMaxScale(target:Sprite):Float {
		var screenSize:Point = getScreenSize();
		var targetOriginalSize:Point = new Point(target.width / target.scaleX, target.height / target.scaleY );
		var maxScale:Float;

		var scale:Point = new Point(
			screenSize.x / 2048,
			screenSize.y / 1366
		);

		return Math.min(scale.x, scale.y);
	}

	private static function getScreenSize():Point {
		return new Point(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
	}

	private static function positionOutOfRangeException():String {
		return 'Screen.hx : position parameter value is incorrect (must be between -1, 1)';
	}
}