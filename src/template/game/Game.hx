package template.game;
import flash.geom.Point;
import haxe.Timer;
import template.utils.game.Containers;
import template.utils.game.GameObject;
import template.utils.game.StateObject;
import template.utils.metadata.LibrariesNames;

class Game {

	public static function start():Void {
		#if showdebuginfo

		#end
		
		var go:GameObject = new GameObject(LibrariesNames.PORTRAIT_UI, "object");
		go.setPositionAt(new Point(200, 200));
		Containers.game.addChild(go);
		
		trace("ScaleX " + go.scaleX);
		trace("Width " + go.width);
		
		Containers.game.scaleX = 2;
		
		trace("ScaleX " + go.scaleX);
		trace("Width " + go.width);
	}

	public static function gameloop(event:Dynamic):Void {
		
	}
}
