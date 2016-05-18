package template.game;
import template.utils.game.GameObject;
import template.utils.metadata.LibrariesNames;

class Game {

	public function new() {
	}

	public static function start():Void {
		#if showdebuginfo

		#end
		
		var go:GameObject = new GameObject(LibrariesNames.PORTRAIT_UI, "gameObjectTest");
		go.x = 200;
		go.y = 200;
		Main.getInstance().stage.addChild(go);
	}

	public static function gameloop(event:Dynamic):Void {
		
	}
}
