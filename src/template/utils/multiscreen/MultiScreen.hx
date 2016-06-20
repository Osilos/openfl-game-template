package template.utils.multiscreen;

import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Point;
import template.utils.screen.Screen;
import openfl.events.Event;
import template.utils.screen.const.ScreenFitsType;
import template.utils.screen.const.ScreenPositions;
import openfl.display.DisplayObject;

/**
 * This class allow you to resize and place your displayObject on screen
 */
@:access(template.utils.multiscreen.MultiScreenBuilder)
class MultiScreen {
	public static inline var DEFAULT_SAFEZONE_WIDTH:Int = 1366;
	public static inline var DEFAULT_SAFEZONE_HEIGHT:Int = 2048;

	private var target:DisplayObject;
	private var screenPositionToPlace:ScreenPositions;
	private var fitType:ScreenFitsType;
	private var safeZoneSize:Point;

	private var useSafeZoneScale:Bool;
	private var mustSetPosition:Bool;
	private var mustFitScreen:Bool;

	public function new(builder:MultiScreenBuilder) {
		this.target = builder.target;
		this.screenPositionToPlace = builder.position;
		this.fitType = builder.fitType;
		this.mustSetPosition = builder.mustSetPosition;
		this.useSafeZoneScale = builder.useSafeZoneScale;
		this.safeZoneSize = builder.safeZoneSize;
		this.mustFitScreen = builder.mustFitScreen;

		handleTarget();
	}

	public function destroy():Void {
		target.removeEventListener(Event.ADDED_TO_STAGE, subscribeResizeEvent);
		target.removeEventListener(Event.REMOVED_FROM_STAGE, unsubscribeResizeEvent);
	}

	private function handleTarget():Void {
		target.addEventListener(Event.ADDED_TO_STAGE, subscribeResizeEvent);
		target.addEventListener(Event.REMOVED_FROM_STAGE, unsubscribeResizeEvent);
		if (target.stage != null) {
			subscribeResizeEvent();
			updateTarget();
		}
	}

	private function subscribeResizeEvent(?event:Dynamic):Void {
		target.stage.addEventListener(Event.RESIZE, updateTarget);
		updateTarget();
	}

	private function unsubscribeResizeEvent(?event:Dynamic):Void {
		target.stage.removeEventListener(Event.RESIZE, updateTarget);
	}

	private function updateTarget(?event:Dynamic):Void {
		updateTargetScaleWithSafeZoneScale();
		updateTargetPosition();
		updateTargetScaleToFitScreen();
	}

	private function updateTargetScaleWithSafeZoneScale():Void {
		if (useSafeZoneScale) {
			var newScale:Float = Screen.getSafeZoneRatio(safeZoneSize);
			target.scaleX = newScale;
			target.scaleY = newScale;
		}
	}

	private function updateTargetPosition():Void {
		if (mustSetPosition) {
			var newPosition:Point = Screen.getPositionAt(screenPositionToPlace);
			target.x = newPosition.x;
			target.y = newPosition.y;
		}
	}

	private function updateTargetScaleToFitScreen():Void {
		if (mustFitScreen) {
			var newScale:Point = Screen.getTargetFitScaleType(fitType, target);
			target.scaleX = newScale.x;
			target.scaleY = newScale.y;
		}
	}
}
