package template;

import haxe.Timer;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.geom.Point;
import template.game.Game;
import template.utils.game.ResizeComp;
import template.utils.game.GameStage;
import template.utils.game.GameStageAlign;
import template.utils.metadata.Metadatas;
import template.utils.debug.GraphicPoint;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{
	public function new() {
		super();
		
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
		
		var comp:ResizeComp 	= new ResizeComp(sprite);
		comp.scaleMode 		    = ScaleMode.SHOW_ALL;
		comp.useSafeZone        = true;
		comp.safeZoneAlignMode  = AlignMode.CENTER;
		comp.alignModeOnResize  = AlignMode.CENTER;
		
		sprite3.addChild(sprite2);
		
		addChild(sprite3);
		sprite2.addChild(sprite);
	}
}
