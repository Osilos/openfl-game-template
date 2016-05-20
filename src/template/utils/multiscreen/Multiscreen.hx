package template.utils.multiscreen;

import template.utils.screen.const.ScreenFitsType;
import template.utils.screen.const.ScreenPositions;
import openfl.display.DisplayObject;

/**
 * This class allow you to resize and place your displayObject on screen
 */
class MultiScreen {
	public static inline var DEFAULT_SAFEZONE_WIDTH:Int = 1366;
	public static inline var DEFAULT_SAFEZONE_HEIGHT:Int = 2048;

	private var target:DisplayObject;
	private var position:ScreenPositions;
	private var fitType:ScreenFitsType;
	private var useSafeZoneScale:Bool;
	private var unhandleCallback:Void->Void;

	private var mustSetPosition:Bool;
	private var mustFitScreen:Bool;

	public function new(builder:MultiScreenBuilder) {
		this.target = builder.target;
		this.position = builder.position;
		this.fitType = builder.fitType;
		this.unhandleCallback = builder.unhandleCallback;
		this.useSafeZoneScale = builder.safeZoneSize;
		this.mustSetPosition = builder.mustSetPosition;
		this.mustFitScreen = builder.mustFitScreen;

		handleTarget();
	}

	private function handleTarget():Void {

	}

}
