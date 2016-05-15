package template.utils.game;

import flash.display.Stage;
import openfl.display.DisplayObject;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Théo Sabattié
 */
class Comp
{
	private var alignModeOnResize:GameStageAlign = GameStageAlign.TOP_LEFT;
	
	private var alignOrigin:AlignOrigin  = AlignOrigin.FROM_STAGE;
	private var scaleMode:StageScaleMode = StageScaleMode.SHOW_ALL;
	
	private var useSafeZone:Bool   = false;
	private var safeZone:Rectangle = new Rectangle(0, 0, 2048, 1366);
	private var offset:Point       = new Point(0, 0);

	private var target:DisplayObject;
	
	public function new(target:DisplayObject) 
	{
		this.target = target;
		
		target.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		target.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		
		if (target.parent != null) {
			addResizeListener();
		}
	}
	
	private function addResizeListener():Void 
	{
		target.stage.addEventListener(Event.RESIZE, onResize);
	}
	
	private function removeResizeListener():Void {
		target.stage.removeEventListener(Event.RESIZE, onResize);	
	}
	
	private function onAddToStage(event:Event):Void {
		addResizeListener();
		onResize();
	}
	
	private function onRemoveFromStage(event:Event):Void {
		removeResizeListener();
	}
	
	private function onResize(?event:Event = null):Void {
		setAlignPos(alignModeOnResize, alignOrigin, offset);
	}
	
	public function setAlignPos(alignMode:GameStageAlign, ?useSafeZone:Bool = false, ?alignOrigin:AlignOrigin = AlignOrigin.FROM_STAGE, ?offset:Point = null):Void {
		trace("coucou : " + alignMode);
		
		if (offset == null) {
			offset = new Point(0, 0);
		}
		
		if (alignOrigin == AlignOrigin.FROM_STAGE) {
			// position x:0 y:0 from stage
			var basePos:Point = target.parent.globalToLocal(new Point(0, 0));
			
			// offset
			basePos.x += offset.x / (target.__worldTransform.a + target.__worldTransform.c);
			basePos.y += offset.y / (target.__worldTransform.b + target.__worldTransform.d);
			
			if (!useSafeZone) {
				if (alignMode == GameStageAlign.CENTER || alignMode == GameStageAlign.LEFT || alignMode == GameStageAlign.RIGHT) {
					basePos.y += (target.stage.stageHeight / 2) / (target.__worldTransform.b + target.__worldTransform.d);
				} else if (alignMode == GameStageAlign.BOTTOM || alignMode == GameStageAlign.BOTTOM_LEFT || alignMode == GameStageAlign.BOTTOM_RIGHT) {
					basePos.y += (target.stage.stageHeight) / (target.__worldTransform.b + target.__worldTransform.d);
				}
				
				if (alignMode == GameStageAlign.CENTER || alignMode == GameStageAlign.TOP || alignMode == GameStageAlign.BOTTOM) {
					basePos.x += (target.stage.stageWidth / 2) / (target.__worldTransform.a + target.__worldTransform.c);
				} else if (alignMode == GameStageAlign.RIGHT || alignMode == GameStageAlign.TOP_RIGHT || alignMode == GameStageAlign.BOTTOM_RIGHT) {
					basePos.x += (target.stage.stageWidth) / (target.__worldTransform.a + target.__worldTransform.c);
				}
			} else {
				
			}
			
			target.x = basePos.x;
			target.y = basePos.y;
		} else {
			
		}
	}
	
	public function setAlignModeOnResize(alignMode:GameStageAlign):Void {
		alignModeOnResize = alignMode;
		onResize();
	}
	
	public function setSafeZone(safeZone:Rectangle):Void {
		this.safeZone = safeZone;
		onResize();
	}
	
	public function destroy():Void {
		removeResizeListener();
		target.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
	}
}

@:enum abstract AlignOrigin(Int){
	public var FROM_STAGE = 0;
	public var FROM_PARENT = 1;
}