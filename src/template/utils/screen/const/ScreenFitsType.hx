package template.utils.screen.const;
import openfl.geom.Point;

/**
 * ...
 * @author Flavien
 */
class ScreenFitsType extends Point {
	public static var FIT_ALL:ScreenFitsType = new ScreenFitsType(1, 1);
	public static var FIT_WIDTH:ScreenFitsType = new ScreenFitsType(1, 0);
	public static var FIT_HEIGHT:ScreenFitsType = new ScreenFitsType(0, 1);

	private function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}
}