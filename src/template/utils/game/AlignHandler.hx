package template.utils.game;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.events.Event;
import openfl.geom.Point;
import template.utils.game.AlignMode;

/**
 * ...
 * @author Théo Sabattié
 */
class AlignHandler extends HandlerOnResize
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
	 * Offset x added after alignment
	 */
	public var offsetX(get, set):Float;
	
	/**
	 * Offset y added after alignment
	 */
	public var offsetY(get, set):Float;
	
	private var offset:Point       = new Point(0, 0);
	
	/**
	 * @param	target : DisplayOject which will be align
	 */
	public function new(target:DisplayObject) 
	{
		super(target);
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
		
		if (alignOrigin == AlignOrigin.FROM_STAGE) {
			alignPosFromStage(alignMode, useSafeZone, offset);
		} else {
			alignPosFromParent(alignMode, useSafeZone, offset);
		}
	}
	
	override function onResize(?event:Event = null):Void 
	{
		if (alignModeOnResize != AlignMode.NO_ALIGN) {
			setAlignPos(alignModeOnResize, useSafeZone, alignOrigin, offset);
		}
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
		var lScaleX:Float = getTargetWorldScaleX();
		var lScaleY:Float = getTargetWorldScaleY();
		
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
		
		if (isChanged && useSafeZone) {
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