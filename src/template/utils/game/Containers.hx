package template.utils.game;

import openfl.Lib;
import openfl.display.MovieClip;

class Containers {
	public static var main:MovieClip;
	public static var menu:MovieClip;
	public static var game:MovieClip;
	public static var hud:MovieClip;
	public static var debug:MovieClip;

	public static function createContainers():Void {
		main = new MovieClip();
		menu = new MovieClip();
		game = new MovieClip();
		hud = new MovieClip();
		debug = new MovieClip();

		Lib.current.stage.addChild(main);
		main.addChild(menu);
		main.addChild(game);
		main.addChild(hud);
		main.addChild(debug);
	}
}
