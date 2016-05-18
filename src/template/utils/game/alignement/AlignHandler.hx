package template.utils.game.alignement;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import template.utils.screen.ScreenPositions;
import template.utils.game.alignement.AlignOrigin;

/**
 * ...
 * @author Théo Sabattié
 */
class AlignHandler extends HandlerOnResize
{
	/**
	 * Alignment style
	 */
	public var alignModeOnResize(default, set):ScreenPositions = ScreenPositions.TOP_LEFT;
	
	/**
	 * Alignement style for safeZone
	 */
	public var safeZoneAlignMode(default, set):ScreenPositions = ScreenPositions.CENTER;
	
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
	private function setAlignPos(alignMode:ScreenPositions, ?useSafeZone:Bool = false, ?alignOrigin:AlignOrigin = AlignOrigin.FROM_STAGE):Void {
		if (target.stage == null && alignOrigin == AlignOrigin.FROM_STAGE) {
			throwExceptionNotOnStage();
		}
		
		if (alignOrigin == AlignOrigin.FROM_STAGE) {
			alignPosFromStage(alignMode, useSafeZone, offset);
		} else {
			alignPosFromParent(alignMode, useSafeZone, offset);
		}
	}
	
	override function onResize(?event:Event = null):Void 
	{
		setAlignPos(alignModeOnResize, useSafeZone, alignOrigin, offset);
	}
	
	private function alignPosFromParent(alignMode:ScreenPositions, useSafeZone:Bool, offset:Point):Void 
	{
		//TODO
		throw "Not implemented";
	}
	
	private function alignPosFrom(container:Sprite) : Void
	{
		var parent:DisplayObjectContainer = container;
		
		// position x:0 y:0 from stage
		var basePos:Point = parent.globalToLocal(new Point(0, 0));
		var targetScaleX:Float = getTargetWorldScaleX();
		var targetScaleY:Float = getTargetWorldScaleY();
		
		// offset
		basePos.x += offset.x / targetScaleX;
		basePos.y += offset.y / targetScaleY;
		
		if (useSafeZone) {
			alignPosFromStageUsingSafeZone(alignMode, basePos, targetScaleX, targetScaleY);
		} else {
			alignPosFromStageUsingScreen(alignMode, basePos, parent, targetScaleX, targetScaleY);
		}
	}
	
	private function alignPosFromStageUsingScreen(alignMode:ScreenPositions, basePos:Point, parent:DisplayObjectContainer, lScaleX:Float, lScaleY:Float):Void 
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
	
	private function alignPosFromStageUsingSafeZone(alignMode:ScreenPositions, basePos:Point, lScaleX:Float, lScaleY:Float):Void {
		updateSafeZonePosition();
		
		var lRatio:Float  = getRatioStageToSafeZone();var lWidth:Float  = safeZone.width * lRatio;
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
	
	private function alignModeIsOnTop(alignMode:ScreenPositions):Bool {
		return alignMode == ScreenPositions.TOP || alignMode == ScreenPositions.TOP_LEFT || alignMode == ScreenPositions.TOP_RIGHT;
	}
	
	private function alignModeIsOnBottom(alignMode:ScreenPositions):Bool {
		return alignMode == ScreenPositions.BOTTOM || alignMode == ScreenPositions.BOTTOM_LEFT || alignMode == ScreenPositions.BOTTOM_RIGHT;
	}
	
	private function alignModeIsOnVecticalMiddle(alignMode:ScreenPositions):Bool {
		return alignMode == ScreenPositions.CENTER || alignMode == ScreenPositions.LEFT || alignMode == ScreenPositions.RIGHT;
	}
	
	private function alignModeIsOnLeft(alignMode:ScreenPositions):Bool {
		return alignMode == ScreenPositions.LEFT || alignMode == ScreenPositions.TOP_LEFT || alignMode == ScreenPositions.BOTTOM_LEFT;
	}
	
	private function alignModeIsOnHorizontalMiddle(alignMode:ScreenPositions):Bool {
		return alignMode == ScreenPositions.TOP || alignMode == ScreenPositions.CENTER || alignMode == ScreenPositions.BOTTOM;
	}
	
	private function alignModeIsOnRight(alignMode:ScreenPositions):Bool {
		return alignMode == ScreenPositions.RIGHT || alignMode == ScreenPositions.TOP_RIGHT || alignMode == ScreenPositions.BOTTOM_RIGHT;
	}
	
	private function set_safeZoneAlignMode(alignMode:ScreenPositions):ScreenPositions {
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
	
	private function set_alignModeOnResize(alignMode:ScreenPositions):ScreenPositions {
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