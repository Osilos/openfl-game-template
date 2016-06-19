package template.utils.game;
import template.utils.multiscreen.MultiScreenBuilder;
import template.utils.multiscreen.MultiScreenBuilder;
import openfl.display.MovieClip;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class StateObject extends GameObject
{
	public static inline var DEFAULT_STATE:String = "Default";
	
	private var currentState:String;
	
	/**
	 * Create StateObject with his default state
	 * @param	libraryName
	 * @param	movieClipName
	 */
	public function new(libraryName:String, movieClipName:String, ?multiScreenBuilder:MultiScreenBuilder) {
		super(libraryName, movieClipName + "_" + DEFAULT_STATE, multiScreenBuilder);

		currentState = DEFAULT_STATE;
	}
	
	/**
	 * Change the current state of the StateObject
	 * @param	state
	 */
	public function setState(state:String) : Void {
		if (state == currentState) return;
		
		movieClipName = getMovieClipNameWithoutState() + "_" + state;
		
		removeChild(anim);
		anim = createAnim(libraryName, movieClipName);
		addChild(anim);
		
		currentState = state;
	}
	
	/**
	 * Return the currentState of the StateObject
	 * @return state
	 */
	public function getState () : String {
		return currentState;
	}
	
	private function getMovieClipNameWithoutState () : String {
		return movieClipName.substring(0, movieClipName.indexOf("_"));
	}
	
}