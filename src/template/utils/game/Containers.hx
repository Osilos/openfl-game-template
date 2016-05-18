package template.utils.game;

import openfl.display.Sprite;
import openfl.Lib;

class Containers {
	public static var main:Sprite;
	public static var game:Sprite;
	public static var hud:Sprite;
	public static var menu:Sprite;
	public static var popin:Sprite;
	public static var debug:Sprite;

	public static function createContainers():Void {
		main = new Sprite();
		game = new Sprite();
		hud = new Sprite();
		menu = new Sprite();
		popin = new Sprite();
		debug = new Sprite();

		Lib.current.stage.addChild(main);
		main.addChild(game);
		main.addChild(hud);
		main.addChild(menu);
		main.addChild(popin);
		main.addChild(debug);
	}

	public static function show(container:Sprite):Void {
		container.visible = true;
	}

	public static function hide(container:Sprite):Void {
		container.visible = false;
	}
}
