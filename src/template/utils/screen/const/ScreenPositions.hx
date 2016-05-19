package template.utils.screen.const;
import openfl.geom.Point;

/**
 * ...
 * @author Flavien
 */
class ScreenPositions extends Point
{
	public static var TOP_LEFT:ScreenPositions = new ScreenPositions( -1, -1);
	public static var TOP_RIGHT:ScreenPositions = new ScreenPositions( 1, -1);
	public static var TOP:ScreenPositions = new ScreenPositions( 0, -1);
	public static var CENTER_LEFT:ScreenPositions = new ScreenPositions( -1, 0);
	public static var CENTER_RIGHT:ScreenPositions = new ScreenPositions( 1, 0);
	public static var CENTER:ScreenPositions = new ScreenPositions( 0, 0);
	public static var BOTTOM_LEFT:ScreenPositions = new ScreenPositions( -1, 1);
	public static var BOTTOM_RIGHT:ScreenPositions = new ScreenPositions( 1, 1);
	public static var BOTTOM:ScreenPositions = new ScreenPositions( 0, 1);

	private function new(x:Float = 0, y:Float = 0) {
		super(x, y);
	}
}