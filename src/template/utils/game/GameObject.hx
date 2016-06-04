package template.utils.game;

import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Lib;

/**
 * ...
 * @author Flavien
 */
class GameObject extends Sprite
{
	private static inline var BOX_SUFFIX:String = "Box";
	
	private var animLibraryName:String;
	private var animName:String;
	private var boxLibraryName:String;
	private var boxName:String;
	
	private var anim:MovieClip;
	private var box:MovieClip;
	
	
	/**
	 * Create a GameObect
	 * @param	library where the movieClip has to be load
	 * @param	movieClipName the name of the MovieClip to load
	 */
	public function new(libraryName:String, movieClipName:String) {
		super();
		
		this.animLibraryName = libraryName;
		this.animName = movieClipName;
		
		anim = createAnim(libraryName, movieClipName);
		addChild(anim);
	}
	
	/**
	 * Destroy the GameObejct
	 */
	public function destroy () : Void  {
		removeChild(anim);
		anim = null;
	}
	
	/**
	 * Get the anim MovieClip of the GameObject
	 * @return anim
	 */
	public function getAnim () : MovieClip {
		return anim;
	}
	
	/**
	 * Set the position of the GameObject from a point
	 * @param	position
	 */
	public function setPositionAt (position:Point) : Void {
		x = position.x;
		y = position.y;
	}
	
	/**
	 * Get the position of the GameObject as Point
	 * @return
	 */
	public function getPosition() : Point {
		return new Point(x, y);
	}
	
	private function createAnim (libraryName:String, movieClipName:String) : MovieClip {
		
	}
	
	private function createAnim (animLibraryName:String, animName:String) : MovieClip {
		var movieClip:MovieClip = Assets.getMovieClip(animLibraryName + ":" + animName);
		if (movieClip == null) throwRessourceNotFoundException(animLibraryName + ":" + animName);
		return movieClip;
	}
	
	private function throwRessourceNotFoundException (resourceName:String) : Void {
		throw "Resource : " + resourceName + " don't find in any load ressource";
	}
	
	private function destroyAnim() : Void {
		if (anim == null) return;
		anim.parent.removeChild(anim);
		anim = null;
	}
	
	private function destroyBox() : Void {
		if (box = null) return;
		box.parent.removeChild(box);
		box = null;
	}
	
	public function destroy () : Void {
		destroyAnim();
		destroyBox();
	}

}