package template;

import openfl.Assets;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.ui.Mouse;
import template.game.Game;
import template.utils.game.GameObject;
import template.utils.game.ResizeComp;
import template.utils.metadata.Metadatas;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	private var clip:MovieClip;
	
	public function new() {
		super();
		
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
		Metadatas.load();
		Game.start();
		
		clip = Assets.getMovieClip("assets:Background");
		//clip.x = stage.width / 2;
		//clip.y = stage.height / 2;
		stage.addChild(clip);
		
		clip.addEventListener(MouseEvent.MOUSE_DOWN, setDrag);
		clip.addEventListener(MouseEvent.MOUSE_UP, unsetDrag);
		
		var resize:ResizeComp = new ResizeComp(clip);
		resize.setAlignPos(AlignMode.NO_ALIGN);
		resize.scaleMode = ScaleMode.FIT_WIDTH;
		
	}
	
	private function unsetDrag(event:Event) : Void {
		clip.stopDrag();
	}
	
	private function setDrag(event:Event) : Void {
		
		clip.startDrag();
		trace("mgu");
	}
}
