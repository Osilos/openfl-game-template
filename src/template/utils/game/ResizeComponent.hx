package template.utils.game;

import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import template.utils.game.AlignMode;
import template.utils.game.AlignOrigin;
import template.utils.game.ScaleMode;

/**
 * Manage behaviour of display object on resize.
 * Manage Alignment and scaling.
 * Note : if you change transform (position or scale) of parents, use forceUpdate method 
 * @author Théo Sabattié
 */
class ResizeComponent
{
	/**
	 * Alignment style
	 */
	public var alignModeOnResize(default, set):AlignMode = AlignMode.TOP_LEFT;
	
	/**
	 * Alignement style for safeZone
	 */
	public var safeZoneAlignMode(default, set):AlignMode = AlignMode.CENTER;
	
	/**
	 * Align origin (FROM_PARENT not implemented)
	 */
	public var alignOrigin(default, set):AlignOrigin = AlignOrigin.FROM_STAGE;
	
	/**
	 * Scale mode on resize
	 * ScaleMode.KEEP_ASPECT conserve aspect even if parents have different scales
	 * ScaleMode.NO_SCALE    do not scale 
	 * ScaleMode.SHOW_ALL    use safeZone for ratio
	 * ScaleMode.FIT_WIDTH 	 fit all width
	 * ScaleMode.FIT_HEIGHT  fit all height
	 * ScaleMode.FIT_ALL 	 fit all screen
	 */
	public var scaleMode(default, set):ScaleMode = ScaleMode.SHOW_ALL;
	
	/**
	 * Offset x added after alignment
	 */
	public var offsetX(get, set):Float;
	
	/**
	 * Offset y added after alignment
	 */
	public var offsetY(get, set):Float;
	
	/**
	 * Determines if safe zone is used for alignment
	 */
	public var useSafeZone(default, set):Bool = false;
	
	private var safeZone:Rectangle = new Rectangle(0, 0, 2048, 1366);
	private var offset:Point       = new Point(0, 0);
	private var target:DisplayObject;
	
	/**
	 * @param	target : DisplayOject which will be transform
	 */
	public function new(target:DisplayObject) 
	{
		this.target = target;
		
		target.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		target.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		
		if (target.stage != null) {
			onAddToStage();
		}
	}
	
	/**
	 * Force update when parents are transformed
	 */
	public function forceUpdate():Void {
		onResize();
	}
	
	/**
	 * Align directly target display object
	 * @param	alignMode 
	 * @param	useSafeZone 
	 * @param	alignOrigin 
	 * @param	offset 
	 */
	public function setAlignPos(alignMode:AlignMode, ?useSafeZone:Bool = false, ?alignOrigin:AlignOrigin = AlignOrigin.FROM_STAGE, ?offset:Point = null):Void {
		if (alignMode == AlignMode.NO_ALIGN) {
			return;
		}
		
		if (target.stage == null && alignOrigin == AlignOrigin.FROM_STAGE) {
			throwExceptionNotOnStage();
		}
		
		if (offset == null) {
			offset = new Point(0, 0);
		}
		
		target.__updateTransforms();
		
		if (alignOrigin == AlignOrigin.FROM_STAGE) {
			alignPosFromStage(alignMode, useSafeZone, offset);
		} else {
			alignPosFromParent(alignMode, useSafeZone, offset);
		}
	}
	
	/**
	 * Set the size of safeZone
	 * @param	safeZone
	 */
	public function setSafeZone(safeZone:Rectangle):Void {
		this.safeZone = safeZone;
		
		if (useSafeZone || scaleMode == ScaleMode.SHOW_ALL) {
			resizeIfOnStage();
		}
	}
	
	/**
	 * Destroy component (component removes all its listeners)
	 */
	public function destroy():Void {
		removeResizeListener();
		target.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
	}
	
	private function addResizeListener():Void 
	{
		target.stage.addEventListener(Event.RESIZE, onResize);
	}
	
	private function removeResizeListener():Void {
		target.stage.removeEventListener(Event.RESIZE, onResize);	
	}
	
	private function onAddToStage(?event:Event=null):Void {
		addResizeListener();
		onResize();
	}
	
	private function onRemoveFromStage(event:Event):Void {
		removeResizeListener();
	}
	
	private function onResize(?event:Event = null):Void {
		if (scaleMode != ScaleMode.NO_SCALE) {
			target.scaleX = target.scaleY = 1;
			target.__updateTransforms();
			
			if (scaleMode == ScaleMode.KEEP_ASPECT) {
				scaleToKeepAspect();
			} else if (scaleMode == ScaleMode.SHOW_ALL) {
				scaleToShowAll();
			} else {
				var ratioStageToSafeZone:Float  = getRatioStageToSafeZone();
				var targetBounds:Rectangle      = target.getBounds(target.stage);
				
				if (scaleMode == ScaleMode.FIT_WIDTH) {
					scaleToFitWidth(ratioStageToSafeZone, targetBounds);
				} else if (scaleMode == ScaleMode.FIT_ALL) {
					scaleToFitAll(ratioStageToSafeZone, targetBounds);
				} else if (scaleMode == ScaleMode.FIT_HEIGHT) {
					scaleToFitHeight(ratioStageToSafeZone, targetBounds);
				}
			} 
		}
			
		if (alignModeOnResize != AlignMode.NO_ALIGN) {
			setAlignPos(alignModeOnResize, useSafeZone, alignOrigin, offset);
		}
	}
	
	private function scaleToFitWidth(ratioStageToSafeZone:Float, targetBounds:Rectangle):Void {
		if (useSafeZone) {
			var lWidth:Float = safeZone.width * ratioStageToSafeZone;
			target.scaleX 	 = lWidth / targetBounds.width;
		} else {
			target.scaleX = target.stage.stageWidth / targetBounds.width;
		}
	}
	
	private function scaleToFitHeight(ratioStageToSafeZone:Float, targetBounds:Rectangle):Void {
		if (useSafeZone) {
			var lHeight:Float = safeZone.height * ratioStageToSafeZone;
			target.scaleY 	  = lHeight / targetBounds.height;
		} else {
			target.scaleY = target.stage.stageHeight / targetBounds.height;
		}
	}
	
	private function scaleToFitAll(ratioStageToSafeZone:Float, targetBounds:Rectangle):Void {
		scaleToFitHeight(ratioStageToSafeZone, targetBounds);
		scaleToFitWidth(ratioStageToSafeZone, targetBounds);
	}
	
	private function scaleToShowAll():Void {
		var lRatio:Float = getRatioStageToSafeZone();
		target.scaleX    = lRatio / getTargetWorldScaleX();
		target.scaleY    = lRatio / getTargetWorldScaleY();
	}
	
	private function scaleToKeepAspect():Void 
	{
		target.scaleX = 1 / getTargetWorldScaleX();
		target.scaleY = 1 / getTargetWorldScaleY();
	}
	
	private function getRatioStageToSafeZone():Float {
		return Math.round(10000 * Math.min(target.stage.stageWidth / safeZone.width, target.stage.stageHeight / safeZone.height)) / 10000;
	}
	
	private function getTargetWorldScaleX():Float {
		return target.__worldTransform.a + target.__worldTransform.c;
	}
	
	private function getTargetWorldScaleY():Float {
		return target.__worldTransform.b + target.__worldTransform.d;
	}
	
	private function alignPosFromParent(alignMode:AlignMode, useSafeZone:Bool, offset:Point):Void 
	{
		//TODO
		throw "Not implemented";
	}
	
	private function alignPosFromStage(alignMode:AlignMode, useSafeZone:Bool, offset:Point) 
	{
		var parent:DisplayObjectContainer = target.parent;
		
		// position x:0 y:0 from stage
		var basePos:Point = parent.globalToLocal(new Point(0, 0));
		var lScaleX:Float = (parent.__worldTransform.a + parent.__worldTransform.c);
		var lScaleY:Float = (parent.__worldTransform.b + parent.__worldTransform.d);
		
		// offset
		basePos.x += offset.x / lScaleX;
		basePos.y += offset.y / lScaleY;
		
		if (useSafeZone) {
			alignPosFromStageUsingSafeZone(alignMode, basePos, lScaleX, lScaleY);
		} else {
			alignPosFromStageUsingScreen(alignMode, basePos, parent, lScaleX, lScaleY);
		}
	}
	
	private function alignPosFromStageUsingScreen(alignMode:AlignMode, basePos:Point, parent:DisplayObjectContainer, lScaleX:Float, lScaleY:Float):Void 
	{
		if (alignModeIsOnVecticalMiddle(alignMode)) {
			basePos.y += (parent.stage.stageHeight / 2) / lScaleY;
		} else if (alignModeIsOnBottom(alignMode)) {
			basePos.y += (parent.stage.stageHeight) / lScaleY;
		}
		
		if (alignModeIsOnHorizontalMiddle(alignMode)) {
			basePos.x += (parent.stage.stageWidth / 2) / lScaleX;
		} else if (alignModeIsOnRight(alignMode)) {
			basePos.x += (parent.stage.stageWidth) / lScaleX;
		}
		
		target.x = basePos.x;
		target.y = basePos.y;
	}
	
	private function alignPosFromStageUsingSafeZone(alignMode:AlignMode, basePos:Point, lScaleX:Float, lScaleY:Float):Void {
		updateSafeZonePosition();
		
		var lRatio:Float  = getRatioStageToSafeZone();
		var lWidth:Float  = safeZone.width * lRatio;
		var lHeight:Float = safeZone.height * lRatio;
		
		if (alignModeIsOnVecticalMiddle(alignMode)) {
			basePos.y += (lHeight / 2) / lScaleY + safeZone.y / lScaleY;
		} else if (alignModeIsOnBottom(alignMode)) {
			basePos.y += (lHeight) / lScaleY + safeZone.y / lScaleY;
		} else {
			basePos.y += safeZone.y / lScaleY;
		}
		
		if (alignModeIsOnHorizontalMiddle(alignMode)) {
			basePos.x += (lWidth / 2) / lScaleX + safeZone.x / lScaleX;
		} else if (alignModeIsOnRight(alignMode)) {
			basePos.x += (lWidth) / lScaleX + safeZone.x / lScaleX;
		}
		
		target.x = basePos.x;
		target.y = basePos.y;
	}
	
	private function throwExceptionNotOnStage():Void 
	{
		throw "Comp :: Child is not added on stage, you can not set align position on this context";
	}
	
	private function updateSafeZonePosition():Void 
	{
		var lRatio:Float  = getRatioStageToSafeZone();
		
		if (alignModeIsOnTop(safeZoneAlignMode)) {
			safeZone.y = 0;
		} else if (alignModeIsOnBottom(safeZoneAlignMode)) {
			safeZone.y = target.stage.stageHeight - safeZone.height * lRatio; 
		} else if (alignModeIsOnVecticalMiddle(safeZoneAlignMode)) {
			safeZone.y = (target.stage.stageHeight - safeZone.height * lRatio) / 2;
		}
		
		if (alignModeIsOnLeft(safeZoneAlignMode)) {
			safeZone.x = 0;
		} else if (alignModeIsOnHorizontalMiddle(safeZoneAlignMode)) {
			safeZone.x = (target.stage.stageWidth - safeZone.width * lRatio) / 2;
		} else if (alignModeIsOnRight(safeZoneAlignMode)) {
			safeZone.x = target.stage.stageWidth - safeZone.width * lRatio;
		}
	}
	
	private function alignModeIsOnTop(alignMode:AlignMode):Bool {
		return alignMode == AlignMode.TOP || alignMode == AlignMode.TOP_LEFT || alignMode == AlignMode.TOP_RIGHT;
	}
	
	private function alignModeIsOnBottom(alignMode:AlignMode):Bool {
		return alignMode == AlignMode.BOTTOM || alignMode == AlignMode.BOTTOM_LEFT || alignMode == AlignMode.BOTTOM_RIGHT;
	}
	
	private function alignModeIsOnVecticalMiddle(alignMode:AlignMode):Bool {
		return alignMode == AlignMode.CENTER || alignMode == AlignMode.LEFT || alignMode == AlignMode.RIGHT;
	}
	
	private function alignModeIsOnLeft(alignMode:AlignMode):Bool {
		return alignMode == AlignMode.LEFT || alignMode == AlignMode.TOP_LEFT || alignMode == AlignMode.BOTTOM_LEFT;
	}
	
	private function alignModeIsOnHorizontalMiddle(alignMode:AlignMode):Bool {
		return alignMode == AlignMode.TOP || alignMode == AlignMode.CENTER || alignMode == AlignMode.BOTTOM;
	}
	
	private function alignModeIsOnRight(alignMode:AlignMode):Bool {
		return alignMode == AlignMode.RIGHT || alignMode == AlignMode.TOP_RIGHT || alignMode == AlignMode.BOTTOM_RIGHT;
	}
	
	private function set_safeZoneAlignMode(alignMode:AlignMode):AlignMode {
		var isChanged = safeZoneAlignMode != alignMode;
		safeZoneAlignMode = alignMode;
		
		if (isChanged && (useSafeZone || scaleMode == ScaleMode.SHOW_ALL)) {
			resizeIfOnStage();
		}
		
		return safeZoneAlignMode;
	}
	
	private function set_alignOrigin(alignOrigin:AlignOrigin):AlignOrigin {
		if (alignOrigin == AlignOrigin.FROM_PARENT) {
			throw "AlignOrigin.FROM_PARENT is not implemented for the moment!";
		}
		
		var isChanged:Bool = this.alignOrigin != alignOrigin;
		this.alignOrigin = alignOrigin;
		
		if (isChanged) {
			resizeIfOnStage();
		}
		
		return this.alignOrigin;
	}
	
	private function set_alignModeOnResize(alignMode:AlignMode):AlignMode {
		var isChanged:Bool = alignModeOnResize != alignMode;
		alignModeOnResize = alignMode;
		
		if (isChanged) {
			resizeIfOnStage();
		}
		
		return alignModeOnResize;
	}
	
	private function set_scaleMode(scaleMode:ScaleMode):ScaleMode {
		var isChanged:Bool = scaleMode != this.scaleMode;
		this.scaleMode = scaleMode;
		
		if (isChanged) {
			resizeIfOnStage();
		}
		
		return this.scaleMode;
	}
	
	private function set_useSafeZone(useSafeZone:Bool):Bool {
		var isChanged:Bool = useSafeZone != this.useSafeZone;
		this.useSafeZone   = useSafeZone;
		
		if (isChanged) {
			resizeIfOnStage();
		}
		
		return this.useSafeZone;
	}
	
	private function resizeIfOnStage():Void {
		if (target.stage != null) {
			onResize();
		}
	}
	
	private function set_offsetX(x:Float):Float {
		offset.x = x;
		resizeIfOnStage();
		return x;
	}
	
	private function set_offsetY(y:Float):Float {
		offset.y = y;
		resizeIfOnStage();
		return y;
	}
	
	private function get_offsetX():Float {
		return offset.x;
	}
	
	private function get_offsetY():Float {
		return offset.y;
	}
}
