package template;

import haxe.Timer;
import openfl.Assets;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import template.game.Game;
import template.utils.game.AlignHandler;
import template.utils.game.AlignMode;
import template.utils.debug.Debug;
import template.utils.debug.DebugInfo;
import template.utils.game.ScaleHandler;
import template.utils.game.ScaleMode;
import template.utils.metadata.Metadatas;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite {
	public function new() {
		super();
		Debug.initDefaultContainer(this); //todo : create debug container
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
		
		Metadatas.load();
		Game.start();
		
		#if showdebuginfo
			var debugInfo:DebugInfo = new DebugInfo();
			addChild(debugInfo);
		#end
		
		var screen:MovieClip = Assets.getMovieClip("TitleCard:TitleCard");
		addChild(screen);
		
		var scaleHandler:ScaleHandler  = new ScaleHandler(screen);
		//scaleHandler.useSafeZone       = true;
		scaleHandler.scaleMode = ScaleMode.FIT_ALL;
		
		var alignHandler:AlignHandler  = new AlignHandler(screen);
		alignHandler.alignModeOnResize = AlignMode.CENTER;
		alignHandler.useSafeZone       = true;
		alignHandler.safeZoneAlignMode = AlignMode.CENTER;
	}
}
