package template.utils.game.scale;
import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.geom.Rectangle;
import template.utils.game.scale.ScaleMode;

/**
 * ...
 * @author Théo Sabattié
 */
class ScaleHandler extends HandlerOnResize
{
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
	 * @param	target : DisplayOject which will be scale
	 */
	public function new(target:DisplayObject) 
	{
		super(target);
	}
	
	override function onResize(?event:Event = null):Void 
	{
		if (scaleMode != ScaleMode.NO_SCALE) {
			target.scaleX = target.scaleY = 1;
			
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
	
	private function set_scaleMode(scaleMode:ScaleMode):ScaleMode {
		var isChanged:Bool = scaleMode != this.scaleMode;
		this.scaleMode     = scaleMode;
		
		if (isChanged) {
			resizeIfOnStage();
		}
		
		return this.scaleMode;
	}
}