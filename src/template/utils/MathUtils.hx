package template.utils;
import openfl.geom.Point;

/**
 * ...
 * @author Flavien
 */
class MathUtils
{

	/**
	 * Return the sign of a Float
	 * @param	number
	 * @return -1 for negative number : 1 for positive number
	 */
	public static function getSign(number:Float) : Float {
		if (number == 0) return 0;
		return number / Math.abs(number);
	}
	
	/**
	 * Get Distance Between two point
	 * @param	pPointA
	 * @param	pPointB
	 * @return
	 */
	public static function getDistance(pointA:Point, pointB:Point):Float {
		return Math.sqrt((pointA.x - pointB.x) * (pointA.x - pointB.x) 
			+ (pointA.y - pointB.y)* (pointA.y - pointB.y));
	}
	
	/**
	 * Calcule la direction entre deux points
	 * @param	pPointA point de référence
	 * @param	pPointB point distance
	 * @return Return l'angle de la direction entre A et B
	 */
	public static function getDirection(pointA:Point, pointB:Point):Float {
		return Math.atan2(pointA.y - pointB.y, pointA.x - pointB.x);
	}
	
	/**
	 * ceil number to close step multiplicator
	 * @param	number
	 * @param	step
	 * @return
	 */
	public static function roundToStep(number:Int, step:Float) : Float {
		return Math.ceil(number / step) * step;
	}
	
	/**
	 * percent of number in total
	 * @param	number
	 * @param	total
	 * @return
	 */
	public static function getPercent (number:Float, total:Float) : Float {
		return 100 / total * number;
	}
	
}