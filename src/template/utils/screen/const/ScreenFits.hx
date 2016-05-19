package template.utils.screen.const;
import openfl.geom.Point;

/**
 * ...
 * @author Flavien
 */
class ScreenFits extends Point
{
	public static var FIT_ALL:ScreenFits = new ScreenFits(1, 1);
	public static var FIT_WIDTH:ScreenFits = new ScreenFits(1, 0);
	public static var FIT_HEIGHT:ScreenFits = new ScreenFits(0, 1);

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}
}