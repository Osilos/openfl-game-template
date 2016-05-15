package template.utils.game;

import flash.display.Stage;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * Note : if you change transform (position or scale) of parents update it 
 * @author Théo Sabattié
 */
class ResizeComp
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
				target.scaleX = 1 / (target.__worldTransform.a + target.__worldTransform.c);
				target.scaleY = 1 / (target.__worldTransform.b + target.__worldTransform.d);
			} else {
				if (scaleMode == ScaleMode.FIT_WIDTH || scaleMode == ScaleMode.FIT_ALL) {
					if (useSafeZone) {
						target.scaleX = target.stage.stageWidth / safeZone.width;
					} else {
						target.scaleX = target.stage.stageWidth / target.getBounds(target.stage).width;
					}
				}
				
				if (scaleMode == ScaleMode.FIT_HEIGHT || scaleMode == ScaleMode.FIT_ALL) {
					if (useSafeZone) {
						target.scaleY = target.stage.stageHeight / safeZone.height;
					} else {
						target.scaleY = target.stage.stageHeight / target.getBounds(target.stage).height;
					}
				}
				
				if (scaleMode == ScaleMode.SHOW_ALL) {
					var lRatio:Float = Math.round(10000 * Math.min(target.stage.stageWidth / safeZone.width, target.stage.stageHeight / safeZone.height)) / 10000;
					target.scaleX    = lRatio / (target.__worldTransform.a + target.__worldTransform.c);
					target.scaleY    = lRatio / (target.__worldTransform.b + target.__worldTransform.d);
				}
			}
		}
			
		if (alignModeOnResize != AlignMode.NO_ALIGN) {
			setAlignPos(alignModeOnResize, useSafeZone, alignOrigin, offset);
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
			throw "Comp :: Child is not added on stage, you can not set align position on this context";
		}
		
		if (offset == null) {
			offset = new Point(0, 0);
		}
		
		target.__updateTransforms();
		
		if (alignOrigin == AlignOrigin.FROM_STAGE) {
			// position x:0 y:0 from stage
			var parent:DisplayObjectContainer = target.parent;
			var basePos:Point = parent.globalToLocal(new Point(0, 0));
			
			var lScaleX:Float = (parent.__worldTransform.a + parent.__worldTransform.c);
			var lScaleY:Float = (parent.__worldTransform.b + parent.__worldTransform.d);
			
			// offset
			basePos.x += offset.x / lScaleX;
			basePos.y += offset.y / lScaleY;
			
			if (useSafeZone) {
				updateSafeZonePosition();
				
				var lRatio:Float  = Math.round(10000 * Math.min(target.stage.stageWidth / safeZone.width, target.stage.stageHeight / safeZone.height)) / 10000;
				var lWidth:Float  = safeZone.width * lRatio;
				var lHeight:Float = safeZone.height * lRatio;
				
				if (alignMode == AlignMode.CENTER || alignMode == AlignMode.LEFT || alignMode == AlignMode.RIGHT) {
					basePos.y += (lHeight / 2) / lScaleY + safeZone.y / lScaleY;
				} else if (alignMode == AlignMode.BOTTOM || alignMode == AlignMode.BOTTOM_LEFT || alignMode == AlignMode.BOTTOM_RIGHT) {
					basePos.y += (lHeight) / lScaleY + safeZone.y / lScaleY;
				} else {
					basePos.y += safeZone.y / lScaleY;
				}
				
				if (alignMode == AlignMode.CENTER || alignMode == AlignMode.TOP || alignMode == AlignMode.BOTTOM) {
					basePos.x += (lWidth / 2) / lScaleX + safeZone.x / lScaleX;
				} else if (alignMode == AlignMode.RIGHT || alignMode == AlignMode.TOP_RIGHT || alignMode == AlignMode.BOTTOM_RIGHT) {
					basePos.x += (lWidth) / lScaleX + safeZone.x / lScaleX;
				}
			} else {
				if (alignMode == AlignMode.CENTER || alignMode == AlignMode.LEFT || alignMode == AlignMode.RIGHT) {
					basePos.y += (parent.stage.stageHeight / 2) / lScaleY;
				} else if (alignMode == AlignMode.BOTTOM || alignMode == AlignMode.BOTTOM_LEFT || alignMode == AlignMode.BOTTOM_RIGHT) {
					basePos.y += (parent.stage.stageHeight) / lScaleY;
				}
				
				if (alignMode == AlignMode.CENTER || alignMode == AlignMode.TOP || alignMode == AlignMode.BOTTOM) {
					basePos.x += (parent.stage.stageWidth / 2) / lScaleX;
				} else if (alignMode == AlignMode.RIGHT || alignMode == AlignMode.TOP_RIGHT || alignMode == AlignMode.BOTTOM_RIGHT) {
					basePos.x += (parent.stage.stageWidth) / lScaleX;
				}
			}
			
			target.x = basePos.x;
			target.y = basePos.y;
		} else {
			
		}
	}
	
	private function updateSafeZonePosition():Void 
	{
		var lRatio:Float  = Math.round(10000 * Math.min(target.stage.stageWidth / safeZone.width, target.stage.stageHeight / safeZone.height)) / 10000;
		
		if (safeZoneAlignMode == AlignMode.TOP || safeZoneAlignMode == AlignMode.TOP_LEFT || safeZoneAlignMode == AlignMode.TOP_RIGHT) {
			safeZone.y = 0;
		} else if (safeZoneAlignMode == AlignMode.BOTTOM || safeZoneAlignMode == AlignMode.BOTTOM_LEFT || safeZoneAlignMode == AlignMode.BOTTOM_RIGHT) {
			safeZone.y = target.stage.stageHeight - safeZone.height * lRatio; 
		} else if (safeZoneAlignMode == AlignMode.CENTER || safeZoneAlignMode == AlignMode.LEFT || safeZoneAlignMode == AlignMode.RIGHT) {
			safeZone.y = (target.stage.stageHeight - safeZone.height * lRatio) / 2;
		}
		
		if (safeZoneAlignMode == AlignMode.LEFT || safeZoneAlignMode == AlignMode.TOP_LEFT || safeZoneAlignMode == AlignMode.BOTTOM_LEFT) {
			safeZone.x = 0;
		} else if (safeZoneAlignMode == AlignMode.TOP || safeZoneAlignMode == AlignMode.CENTER || safeZoneAlignMode == AlignMode.BOTTOM) {
			safeZone.x = (target.stage.stageWidth - safeZone.width * lRatio) / 2;
		} else if (safeZoneAlignMode == AlignMode.RIGHT || safeZoneAlignMode == AlignMode.TOP_RIGHT || safeZoneAlignMode == AlignMode.BOTTOM_RIGHT) {
			safeZone.x = target.stage.stageWidth - safeZone.width * lRatio;
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
	
	private function set_safeZoneAlignMode(alignMode:AlignMode):AlignMode {
		var isChanged = safeZoneAlignMode != alignMode;
		safeZoneAlignMode = alignMode;
		
		if (isChanged && (useSafeZone || scaleMode == ScaleMode.SHOW_ALL)) {
			resizeIfOnStage();
		}
		
		return safeZoneAlignMode;
	}
	
	private function set_alignOrigin(alignOrigin:AlignOrigin):AlignOrigin {
		if (alignOrigin = AlignOrigin.FROM_PARENT) {
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
	
	/**
	 * Destroy component (component removes all its listeners)
	 */
	public function destroy():Void {
		removeResizeListener();
		target.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
	}
}

@:enum abstract AlignOrigin(Int){
	public var FROM_STAGE = 0;
	//public var FROM_PARENT = 1;
}

@:enum abstract AlignMode(Int){
	public var NO_ALIGN 	= 0;
	public var TOP 			= 1;
	public var TOP_LEFT 	= 2;
	public var TOP_RIGHT 	= 3;
	public var CENTER 		= 4;
	public var LEFT 		= 5;
	public var RIGHT 		= 6;
	public var BOTTOM 		= 7;
	public var BOTTOM_LEFT  = 8;
	public var BOTTOM_RIGHT = 9;
}

@:enum abstract ScaleMode(Int){
	public var KEEP_ASPECT 	= 0;
	public var NO_SCALE     = 1;
	public var SHOW_ALL 	= 2;
	public var FIT_WIDTH 	= 3;
	public var FIT_HEIGHT 	= 4;
	public var FIT_ALL 		= 5;
}