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
	private var boxLibraryName:String;
	
	private var animName:String;
	private var boxName:String;
	
	private var anim:MovieClip;
	private var box:MovieClip;
	
	
	/**
	 * Create a GameObect
	 * @param	animLibraryName where the movieClip has to be load
	 * @param	animName the name of the MovieClip to load
	 */
	public function new(animLibraryName:String, animName:String) {
		super();
		
		this.animLibraryName = animLibraryName;
		this.animName = animName;
		
		anim = createMovieClip(animLibraryName, animName);
		addChild(anim);
	}
	
	/**
	 * Destroy the GameObejct
	 */
	public function destroy () : Void  {
		destroyAnim();
		destroyBox();
	}
	
	/**
	 * Create the Box of the GameObject
	 * @param	boxLibraryName where the movieClip has to be load
	 * @param	boxName = animName + BOX_SUFFIX. The name of the MovieClip to load
	 */
	public function createBox (boxLibraryName:String, ?boxName = null) : Void {
		this.boxLibraryName = boxLibraryName;
		this.boxName = boxName == null ? animName + BOX_SUFFIX : boxName;
		
		box = createMovieClip(boxLibraryName, boxName);
		addChild(box);
		box.visible = false;
		
		#if showdebuginfo
		box.visible = true;
		#end
	}
	
	/**
	 * Get the anim MovieClip of the GameObject
	 * @return anim
	 */
	public function getAnim () : MovieClip {
		if (anim == null)
			throw objectNotSetException("anim");
		return anim;
	}
	
	/**
	 * Get the Box of the GameObject
	 * @return
	 */
	public function getBox () : MovieClip {
		if (box == null)
			throw objectNotSetException("box");
		return box;
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
	
	private function createMovieClip (libraryName:String, movieClipName:String) : MovieClip {
		var movieClip:MovieClip = Assets.getMovieClip(animLibraryName + ":" + animName);
		if (movieClip == null) throw ressourceNotFoundException(animLibraryName + ":" + animName);
		return movieClip;
	}
	
	private function objectNotSetException (object:String) : String {
		return "GameObject : no " + object + " is create ";
	}
	
	private function ressourceNotFoundException (resourceName:String) : String {
		return "Resource : " + resourceName + " don't find in any load ressource";
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
}