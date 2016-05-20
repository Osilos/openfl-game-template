package template.utils.multiscreen;

import openfl.geom.Point;
import template.utils.screen.const.ScreenFitsType;
import template.utils.screen.const.ScreenPositions;
import openfl.display.DisplayObject;

@:access(template.utils.multiscreen.MultiScreen)
class MultiScreenBuilder {
	private static inline var MISSING_PARAMETERS_EXCEPTION:String =
	'MultiScreenBuilder : Missing required parameters.\n' +
	'\n' +
	'Usage : \n' +
	'MultiScreenBuilder.create()\n' +
	'                  .withTargetToHandle(target:DisplayObject) (Required)\n' +
	'                  .withPlacementPosition(position:ScreenPositions) (Optional)\n' +
	'                  .withScreenFitting(fitType:ScreenFitsType) (Optional)\n' +
	'                  .withSafeZoneScaling(useSafeZoneScale:Bool) (Optional) (Default: false)\n' +
	'                  .withSafeZoneSize(safeZoneSize:Point) (Optional) (Default: DEFAULT_SAFEZONE_WIDTH, DEFAULT_SAFEZONE_HEIGHT)\n' +
	'                  .withUnhandleCallback(unhandleCallback:Void->Void) (Optional)\n' +
	'                  .build()';

	private var target:DisplayObject;
	private var position:ScreenPositions;
	private var fitType:ScreenFitsType;
	private var useSafeZoneScale:Bool;
	private var safeZoneSize:Point;
	private var unhandleCallback:Void->Void;

	private var mustSetPosition:Bool;
	private var mustFitScreen:Bool;

	/**
	 * Usage :
	 * MultiScreenBuilder.create()
	 * 				  	 .withTargetToHandle(target:DisplayObject) (Required)
	 *	   				 .withPlacementPosition(position:ScreenPositions) (Optional)
	 *	   				 .withScreenFitting(fitType:ScreenFitsType) (Optional)
	 *	   				 .withSafeZoneScaling(useSafeZoneScale:Bool) (Optional) (Default: false)
	 *	   				 .withSafeZoneSize(safeZoneSize:Point) (Optional) (Default: DEFAULT_SAFEZONE_WIDTH, DEFAULT_SAFEZONE_HEIGHT)
	 *	   				 .withUnhandleCallback(unhandleCallback:Void->Void) (Optional)
	 * 				   	 .build()
     **/

	public function new() {
	}

	public static function create():MultiScreenBuilder {
		return new MultiScreenBuilder();
	}

	public function withTargetToHandle(target:DisplayObject):MultiScreenBuilder {
		this.target = target;
		return this;
	}

	public function withPlacementPosition(position:ScreenPositions):MultiScreenBuilder {
		this.position = position;
		return this;
	}

	public function withScreenFitting(fitType:ScreenFitsType):MultiScreenBuilder {
		this.fitType = fitType;
		return this;
	}

	public function withSafeZoneScaling(useSafeZoneScale:Bool):MultiScreenBuilder {
		this.useSafeZoneScale = useSafeZoneScale;
		return this;
	}

	public function withSafeZoneSize(safeZoneSize:Point):MultiScreenBuilder {
		this.safeZoneSize = safeZoneSize;
		return this;
	}

	public function withUnhandleCallback(unhandleCallback:Void->Void):MultiScreenBuilder {
		this.unhandleCallback = unhandleCallback;
		return this;
	}

	public function build():MultiScreen {
		setDefaultUsingFitParameter();
		setDefaultPlacementPosition();
		setDefaultSafeZoneUsing();
		setDefaultSafeZoneSize();
		setDefaultUnhandleCallback();
		return new MultiScreen(this);
	}

	private function missingParametersException():String {
		if (target == null) {
			return MISSING_PARAMETERS_EXCEPTION;
		}
	}

	private function setDefaultUsingFitParameter():Void {
		mustFitScreen = fitType != null;
	}

	private function setDefaultPlacementPosition():Void {
		mustSetPosition = position != null;
	}

	private function setDefaultSafeZoneUsing():Void {
		if (useSafeZoneScale == null) {
			useSafeZoneScale = false;
		}
	}

	private function setDefaultSafeZoneSize():Void {
		if (safeZoneSize == null) {
			safeZoneSize = new Point(
				MultiScreen.DEFAULT_SAFEZONE_WIDTH,
				MultiScreen.DEFAULT_SAFEZONE_HEIGHT
			);
		}
	}

	private function setDefaultUnhandleCallback():Void {
		if (unhandleCallback == null) {
			unhandleCallback = function () {};
		}
	}
}
