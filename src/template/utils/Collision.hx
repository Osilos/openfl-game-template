package template.utils;
import openfl.display.MovieClip;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import template.utils.game.Containers;

/**
 * Provide collisions functions
 * @author Flavien
 */
class Collision {

    /**
    * Determine if the two MovieClip had collision
    * @param MovieClip objectA
    * @param MovieClip objectB
    * @return the result of collision
    **/
    public static function betweenTwoMovieClip (objectA:MovieClip, objectB:MovieClip) : Bool {
        var rectangleA:Rectangle = objectA.getRect(Containers.main);
        var rectangleB:Rectangle = objectB.getRect(Containers.main);
        return rectangleA.intersects(rectangleB);
    }

    /**
    * Determine if the MovieClip contain the point
    * @param MovieClip objectA
    * @param Point point
    * @return the result of collision
    **/
    public static function betweenPointAndMovieClip(object:MovieClip, point:Point) : Bool {
        var rectangle:Rectangle = object.getRect(Containers.main);
        return rectangle.containsPoint(point);
    }
}