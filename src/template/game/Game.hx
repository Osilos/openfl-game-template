package template.game;
import flash.geom.Point;
import template.game.metadata.LibrariesNames;
import template.utils.game.Containers;
import template.utils.game.GameObject;
import template.utils.game.StateObject;

class Game {

	public static function start():Void {
		var go:GameObject = new GameObject(LibrariesNames.ASSETS, "Wall");
		go.createBox(LibrariesNames.BOXES);
		Containers.game.addChild(go);
		
		var god:GameObject = new GameObject(LibrariesNames.ASSETS, "Wall");
		god.createBox(LibrariesNames.BOXES);
		god.setPositionAt(new Point(0, 100));
		Containers.game.addChild(god);
		
		
		var sO:StateObject = new StateObject(LibrariesNames.ASSETS, "Player");
		sO.createBox(LibrariesNames.BOXES, "WallBox");
		sO.setPositionAt(new Point(200, 200));
		Containers.game.addChild(sO);
		sO.setState("run");
		
		
	}

	public static function gameloop(event:Dynamic):Void {
		
	}
}
