package template.utils.game;

/**
 * ...
 * @author Théo Sabattié
 */
@:enum abstract AlignMode(Int){
	public var NO_ALIGN 	= 0;
	public var TOP 			= 1;
	public var TOP_LEFT 	= 2;
	public var TOP_RIGHT 	= 3;
	public var CENTER 		= 4;
	public var LEFT 		= 5;
	public var RIGHT 		= 6;
	public var BOTTOM 		= 7;
	public var BOTTOM_LEFT  = 8;
	public var BOTTOM_RIGHT = 9;
}