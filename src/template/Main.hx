package template;

import haxe.Timer;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import template.game.Game;
import template.utils.game.AlignMode;
import template.utils.game.ResizeComponent;
import template.utils.debug.Debug;
import template.utils.debug.DebugInfo;
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
		
		var sprite2:Sprite = new Sprite();
		var sprite3:Sprite = new Sprite();
		sprite2.x += 200;
		sprite2.y += 50;
		
		sprite2.scaleX = sprite2.scaleY = 2;
		sprite3.scaleX = sprite3.scaleY = 2;
		
		var sprite:Sprite = Assets.getMovieClip("TitleCard:TitleCard");
		
		var comp:ResizeComponent 	= new ResizeComponent(sprite);
		comp.scaleMode 		    = ScaleMode.FIT_ALL;
		comp.useSafeZone        = true;
		comp.safeZoneAlignMode  = AlignMode.CENTER;
		comp.alignModeOnResize  = AlignMode.CENTER;
		
		sprite3.addChild(sprite2);
		
		addChild(sprite3);
		sprite2.addChild(sprite);
		// todo : move to Game.hx when we have GameStage
		#if showdebuginfo
			var debugInfo:DebugInfo = new DebugInfo();
			addChild(debugInfo);
		#end
	}
}
