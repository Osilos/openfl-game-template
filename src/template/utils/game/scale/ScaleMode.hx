package template.utils.game.scale;

/**
 * ...
 * @author Théo Sabattié
 */
@:enum abstract ScaleMode(Int){
	public var KEEP_ASPECT 	= 0;
	public var NO_SCALE     = 1;
	public var SHOW_ALL 	= 2;
	public var FIT_WIDTH 	= 3;
	public var FIT_HEIGHT 	= 4;
	public var FIT_ALL 		= 5;
}