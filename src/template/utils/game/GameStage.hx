package template.utils.game;

import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.geom.Rectangle;
import template.utils.game.GameStageAlign;

/**
 * Class used for graphics structure (various Containers)
 * and resize management related to context
 * @author Théo Sabattié
 */
class GameStage extends DisplayObjectContainer
{
	private static inline var SAFE_ZONE_WIDTH:Int  = 2048;
	private static inline var SAFE_ZONE_HEIGHT:Int = 1366;
	
	private var _alignMode:GameStageAlign = GameStageAlign.CENTER;	
	private var _scaleMode:StageScaleMode = StageScaleMode.SHOW_ALL;
	private var _safeZone:Rectangle 	  = new Rectangle(0, 0, SAFE_ZONE_WIDTH, SAFE_ZONE_HEIGHT);
	
	private var gameContainer:DisplayObjectContainer;
	
	/**
	 * Alignment style for view
	 */
	public var alignMode(get, set):GameStageAlign;
	
	/**
	 * Resize mode for view
	 */
	public var scaleMode(get, set):StageScaleMode;
	
	/**
	 * Rectangle wich delimits viewed area
	 */
	public var safeZone(get, never):Rectangle;
	
	/**
	 * Determines if the gameContainer is on the center (or top left)
	 */
	public var centerGameContainer(default, set):Bool;
	
	/**
	 * Determines the width of the safezone
	 */
	public var safeZoneWidth(get, set):UInt;
	
	/**
	 * Determines the height of the safezone
	 */
	public var safeZoneHeight(get, set):UInt;
	
	public function new() 
	{
		super();
		
		gameContainer = new DisplayObjectContainer();
		addChild(gameContainer);
		addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
	}
	
	private function onAddToStage(event:Event):Void {
		parent.stage.addEventListener(Event.RESIZE, resize);
	}
	
	private function onRemoveFromStage(event:Event):Void {
		parent.stage.removeEventListener(Event.RESIZE, resize);
	}
	
	/**
	 * Add child to gameContainer
	 * @param   game
	 */
	public function addGameChild(game:DisplayObject):Void {
		gameContainer.addChild(game);
	}
	
	/**
	 * Remove child from gameContainer
	 * @param	game
	 */
	public function removeGameChild(game:DisplayObject):Void {
		gameContainer.removeChild(game);
	}
	
	
	/**
	 * Resize scene from window's size
	 */
	public function resize(?event:Event = null):Void {
		var lWidth:Float  = parent.stage.stageWidth;
		var lHeight:Float = parent.stage.stageHeight;
		var lRatio:Float  = Math.round(10000 * Math.min( lWidth / safeZone.width, lHeight / safeZone.height)) / 10000;
		
		if (scaleMode == StageScaleMode.SHOW_ALL) scaleY = scaleX = lRatio;
		else scaleY = scaleX = 1;
		// TODO Complete with other ScaleMode
		
		if (alignMode == GameStageAlign.LEFT || alignMode == GameStageAlign.TOP_LEFT || alignMode == GameStageAlign.BOTTOM_LEFT) x = 0;
		else if (alignMode == GameStageAlign.RIGHT || alignMode == GameStageAlign.TOP_RIGHT || alignMode == GameStageAlign.BOTTOM_RIGHT) x = lWidth - safeZone.width * scaleX;
		else x = (lWidth - safeZone.width * scaleX) / 2;
		
		if (alignMode == GameStageAlign.TOP || alignMode == GameStageAlign.TOP_LEFT || alignMode == GameStageAlign.TOP_RIGHT) y = 0;
		else if (alignMode == GameStageAlign.BOTTOM || alignMode == GameStageAlign.BOTTOM_LEFT || alignMode == GameStageAlign.BOTTOM_RIGHT) y = lHeight - safeZone.height * scaleY;
		else y = (lHeight - safeZone.height * scaleY) / 2;
	}
	
	private function setCenter(container:DisplayObjectContainer, isCenter:Bool):Void {
		if (isCenter) {
			container.x = safeZone.width / 2;
			container.y = safeZone.height / 2;	
		} else {
			container.x = container.y = 0;
		}
	}
	
	private function set_centerGameContainer(isCenter:Bool):Bool {
		setCenter(gameContainer, isCenter);
		return centerGameContainer = isCenter;
	}
	
	private function get_alignMode():GameStageAlign { 
		return _alignMode;
	}
	
	private function set_alignMode(pAlign:GameStageAlign) {
		_alignMode = pAlign;
		resize();
		return _alignMode;
	}
	
	private function get_scaleMode():StageScaleMode { 
		return _scaleMode;
	}
	
	private function set_scaleMode(pScale:StageScaleMode):StageScaleMode {
		_scaleMode = pScale;
		resize();
		return _scaleMode;
	}	
	
	private function get_safeZone():Rectangle {
		return _safeZone.clone();
	}
	
	private function get_safeZoneWidth():UInt {
		return Math.round(_safeZone.width);
	}
	
	private function get_safeZoneHeight():UInt {
		return Math.round(_safeZone.height);
	}
	
	private function set_safeZoneWidth(width:UInt):UInt {
		_safeZone.width = width;
		replaceAll();
		
		return width;
	}
	
	private function set_safeZoneHeight(height:UInt):UInt {
		_safeZone.height = height;
		replaceAll();
		
		return height;
	}
	
	private function replaceAll():Void {
		resize();
		setCenter(gameContainer, centerGameContainer);
	}
	
	/**
	 * Destroy GameStage instance (remove listeners and remove from scene)
	 */
	public function destroy():Void {
		if (parent != null) {
			parent.removeEventListener(Event.RESIZE, resize);
			parent.removeChild(this);
		}
		
		removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
	}
}