package template.utils.multiscreen;

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
	'                  .withScreenPosition(position:ScreenPositions) (Required)\n' +
	'                  .withScreenFittingType(fitType:ScreenFitsType) (Optional)\n' +
	'                  .build()';

	private var target:DisplayObject;
	private var position:ScreenPositions;
	private var fitType:ScreenFitsType;
	private var usingFit:Bool;

	/**
	 * Usage :
	 * MultiScreenBuilder.create()
	 * 				  	 .withTargetToHandle(target:DisplayObject) (Required)
	 *	   				 .withScreenPosition(position:ScreenPositions) (Required)
	 *	   				 .withScreenFittingType(fitType:ScreenFitsType) (Optional)
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

	public function withScreenPosition(position:ScreenPositions):MultiScreenBuilder {
		this.position = position;
		return this;
	}

	public function withScreenFittingType(fitType:ScreenFitsType):MultiScreenBuilder {
		this.fitType = fitType;
		return this;
	}

	public function build():MultiScreen {
		setDefaultUsingFitParameter();
		return new MultiScreen(this);
	}

	private function missingParametersException():String {
		if (
			target == null ||
			position == null
		) {
			return MISSING_PARAMETERS_EXCEPTION;
		}
	}

	private function setDefaultUsingFitParameter():Void {
		usingFit = fitType != null;
	}
}
