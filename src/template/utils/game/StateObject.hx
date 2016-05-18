package template.utils.game;
import openfl.display.MovieClip;

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
	public function new(libraryName:String, movieClipName:String) {
		super(libraryName, movieClipName + "_" + DEFAULT_STATE);
		
		currentState = DEFAULT_STATE;
	}
	
	/**
	 * Change the current state of the StateObject
	 * @param	state
	 */
	public function setState(state:String) : Void {
		if (state == currentState) return;
		
		removeChild(anim);
		anim = createAnim(libraryName, movieClipName + "_" + state);
		addChild(anim);
	}
	
	/**
	 * Return the currentState of the StateObject
	 * @return state
	 */
	public function getState () : String {
		return currentState;
	}
	
}