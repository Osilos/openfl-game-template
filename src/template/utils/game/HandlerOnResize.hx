package template.utils.game;

import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.geom.Rectangle;

/**
 * Parent class used to handle displayObject on resizing
 * @author Théo Sabattié
 */
class HandlerOnResize extends DisplayObjectHandler
{
	/**
	 * Determines if safe zone is used for alignment
	 */
	public var useSafeZone(default, set):Bool = false;
	
	private function set_useSafeZone(useSafeZone:Bool):Bool {
		var isChanged:Bool = useSafeZone != this.useSafeZone;
		this.useSafeZone   = useSafeZone;
		
		if (isChanged) {
			resizeIfOnStage();
		}
		
		return this.useSafeZone;
	}
	
	//to do get from config file
	private var safeZone:Rectangle = new Rectangle(0, 0, 2048, 1366);
	
	
	private function new(target:DisplayObject) 
	{
		super(target);
		
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
	 * Set the size of safeZone
	 * @param	safeZone
	 */
	public function setSafeZone(safeZone:Rectangle):Void {
		this.safeZone = safeZone;
		
		if (useSafeZone) {
			resizeIfOnStage();
		}
	}
	
	private function onResize(?event:Event = null):Void {
		
	}
	
	private function addResizeListener():Void 
	{
		target.stage.addEventListener(Event.RESIZE, onResize);
	}
	
	private function removeResizeListener():Void {
		target.stage.removeEventListener(Event.RESIZE, onResize);	
	}
	
	override private function onAddToStage(?e:Event = null):Void 
	{
		addResizeListener();
		onResize();
	}
	
	override function onRemoveFromStage(e:Event):Void 
	{
		removeResizeListener();
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		removeResizeListener();
	}
	
	private function resizeIfOnStage():Void {
		if (target.stage != null) {
			onResize();
		}
	}
	
	private function getTargetWorldScaleX():Float {
		return target.getBounds(target.stage).width / target.width;
	}
	
	private function getTargetWorldScaleY():Float {
		return target.getBounds(target.stage).height / target.height;
	}
	
	private function getRatioStageToSafeZone():Float {
		return Math.round(10000 * Math.min(target.stage.stageWidth / safeZone.width, target.stage.stageHeight / safeZone.height)) / 10000;
	}
}