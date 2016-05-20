package template.utils.multiscreen;

import template.utils.screen.const.ScreenFitsType;
import template.utils.screen.const.ScreenPositions;
import openfl.display.DisplayObject;

/**
 * This class allow you to resize and place your displayObject on screen
 * @author Flavien
 */
class MultiScreen {
	private var target:DisplayObject;
	private var position:ScreenPositions;
	private var fitType:ScreenFitsType;
	private var usingFit:Bool;

	public function new(builder:MultiScreenBuilder) {
		this.target = builder.target;
		this.position = builder.position;
		this.fitType = builder.fitType;
		this.usingFit = builder.usingFit;
	}
}
