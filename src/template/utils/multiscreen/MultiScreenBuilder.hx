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
	'                  .withUsingSafeZoneScaling(useSafeZoneScale:Bool) (Optional) (Default: false)\n' +
	'                  .withSafeZoneSize(safeZoneSize:Point) (Optional) (Default: DEFAULT_SAFEZONE_WIDTH, DEFAULT_SAFEZONE_HEIGHT)\n' +
	'                  .build()';

	private var target:DisplayObject;
	private var position:ScreenPositions;
	private var fitType:ScreenFitsType;
	private var safeZoneSize:Point;

	private var useSafeZoneScale:Bool = false;
	private var mustSetPosition:Bool = false;
	private var mustFitScreen:Bool = false;

	/**
	 * Usage :
	 * MultiScreenBuilder.create()
	 * 				  	 .withTargetToHandle(target:DisplayObject) (Required)
	 *	   				 .withPlacementPosition(position:ScreenPositions) (Optional)
	 *	   				 .withScreenFitting(fitType:ScreenFitsType) (Optional)
	 *	   				 .withUsingSafeZoneScaling(useSafeZoneScale:Bool) (Optional) (Default: false)
	 *	   				 .withSafeZoneSize(safeZoneSize:Point) (Optional) (Default: DEFAULT_SAFEZONE_WIDTH, DEFAULT_SAFEZONE_HEIGHT)
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

	public function withUsingSafeZoneScaling(useSafeZoneScale:Bool):MultiScreenBuilder {
		this.useSafeZoneScale = useSafeZoneScale;
		return this;
	}

	public function withSafeZoneSize(safeZoneSize:Point):MultiScreenBuilder {
		this.safeZoneSize = safeZoneSize;
		return this;
	}

	public function build():MultiScreen {
		if (target == null) {
			throw missingParametersException();
		}
		setDefaultUsingFitParameter();
		setDefaultPlacementPosition();
		setDefaultSafeZoneSize();
		return new MultiScreen(this);
	}

	private function missingParametersException():String {
		return MISSING_PARAMETERS_EXCEPTION;
	}

	private function setDefaultUsingFitParameter():Void {
		mustFitScreen = fitType != null;
	}

	private function setDefaultPlacementPosition():Void {
		mustSetPosition = position != null;
	}

	private function setDefaultSafeZoneSize():Void {
		if (safeZoneSize == null) {
			safeZoneSize = new Point(
				MultiScreen.DEFAULT_SAFEZONE_WIDTH,
				MultiScreen.DEFAULT_SAFEZONE_HEIGHT
			);
		}
	}
}
