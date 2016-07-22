package template.utils.game;
import openfl.display.MovieClip;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class StateObject extends GameObject
{
	public static inline var DEFAULT_STATE:String = "default";
	
	private var currentState:String;
	
	/**
	 * Create StateObject with his default state
	 * @param	libraryName
	 * @param	movieClipName
	 */
	public function new(animLibraryName:String, animName:String) {
		super(animLibraryName, animName + "_" + DEFAULT_STATE);

		currentState = DEFAULT_STATE;
	}
	
	/**
	 * Change the current state of the StateObject
	 * @param	state
	 */
	public function setState(state:String) : Void {
		if (state == currentState) return;
		
		animName = getNameWithoutState(animName) + "_" + state;
		
		destroyAnim();
		anim = createMovieClip(animLibraryName, animName);
		addChild(anim);
		
		currentState = state;
		
		if (collisionBox == null) return;
		
		createBox(boxLibraryName);
	}
	
	/**
	 * Return the currentState of the StateObject
	 * @return state
	 */
	public function getState () : String {
		return currentState;
	}
	
	override private function setCollisionBoxInformation(boxLibraryName:String, ?boxName:String = null):Void 
	{
		this.boxLibraryName = boxLibraryName;
		
		if (this.collisionBoxName != null) {
			this.collisionBoxName = getNameWithoutState(this.collisionBoxName) + "_" + currentState;
		} else {
			this.collisionBoxName = collisionBoxName == null ? 
				getNameWithoutState(animName) + GameObject.BOX_SUFFIX + "_" + currentState 
				: boxName + "_" + currentState;
		}
	}
	
	
	private function getNameWithoutState (name:String) : String {
		return name.substring(0, name.indexOf("_"));
	}
}