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
	 * Get the angle between pointA and pointB
	 * @param	pointA
	 * @param	pointB
	 * @return a float between -Pi and Pi
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
		return number / total;
	}
	
	/**
	 * Get random number between LimiteA and LimiteB
	 * @param	limiteA
	 * @param	limiteB
	 * @return
	 */
	public static function getRandomNumberBetween(limiteA:Float, limiteB:Float) : Float {
		if (limiteA > limiteB) {
			throwExceptionRandomNumberBetween();
			return null;
		}
		
		var deltaBetweenLimites:Float = limiteB - limiteA;
		var randomNumber:Float = Math.round(Math.random() * deltaBetweenLimites);
		return randomNumber + limiteA;
	}
	
	private static function throwExceptionRandomNumberBetween() : Void {
		throw "MathUtils.getRandomNumberBetween : limiteB should be greater than limiteA";
	}
	
}