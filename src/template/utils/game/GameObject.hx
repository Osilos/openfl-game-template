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
	private var anim:MovieClip;
	
	/**
	 * Create a GameObect
	 * @param	library where the movieClip has to be load
	 * @param	movieClipName the name of the MovieClip to load
	 */
	public function new(libraryName:String, movieClipName:String) 
	{
		super();
		
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
	
	private function createAnim (libraryName:String, movieClipName:String) : MovieClip {
		return Assets.getMovieClip(libraryName+":"+movieClipName);
	}
	

}