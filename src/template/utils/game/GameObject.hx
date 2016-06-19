package template.utils.game;

import template.utils.multiscreen.MultiScreen;
import template.utils.multiscreen.MultiScreenBuilder;
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
	private var libraryName:String;
	private var movieClipName:String;
	
	private var anim:MovieClip;
	private var multiScreen:MultiScreen;
	
	/**
	 * Create a GameObect
	 * @param	library where the movieClip has to be load
	 * @param	movieClipName the name of the MovieClip to load
	 */
	public function new(libraryName:String, movieClipName:String, ?multiScreenBuilder:MultiScreenBuilder) {
		super();


		this.libraryName = libraryName;
		this.movieClipName = movieClipName;

		anim = createAnim(libraryName, movieClipName);
		addChild(anim);

		applyMultiScreen(multiScreenBuilder);
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

	private function applyMultiScreen(multiScreenBuilder:MultiScreenBuilder):Void {
		if (multiScreenBuilder != null) {
			multiScreenBuilder.withTargetToHandle(getAnim()).build();
		} else {
//			multiScreen = MultiScreenBuilder.create()
//											.withTargetToHandle(getAnim())
//											.withUsingSafeZoneScaling(true)
//											.build();
		}
	}
	
	private function createAnim (libraryName:String, movieClipName:String) : MovieClip {
		var movieClip:MovieClip = Assets.getMovieClip(libraryName + ":" + movieClipName);
		if (movieClip == null) throwRessourceNotFoundException(libraryName + ":" + movieClipName);
		return movieClip;
	}
	
	private function throwRessourceNotFoundException (resourceName:String) : Void {
		throw "Resource : " + resourceName + " don't find in any load ressource";
	}
	

}