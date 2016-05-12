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
	private var hudContainer:DisplayObjectContainer;
	private var screenContainer:DisplayObjectContainer;
	private var popinContainer:DisplayObjectContainer;
	
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
	 * Determines align mode of game container (result depends of GameStage align mode [GameStageAlign.CENTER advisable])
	 */
	public var gameContainerAlignMode(default, set):GameStageAlign;
	
	/**
	 * Determines align mode of hud container (result depends of GameStage align mode [GameStageAlign.CENTER advisable])
	 */
	public var hudContainerAlignMode(default, set):GameStageAlign;
	
	/**
	 * Determines align mode of screen container (result depends of GameStage align mode [GameStageAlign.CENTER advisable])
	 */
	public var screenContainerAlignMode(default, set):GameStageAlign;
	
	/**
	 * Determines align mode of popin container (result depends of GameStage align mode [GameStageAlign.CENTER advisable])
	 */
	public var popinContainerAlignMode(default, set):GameStageAlign;
	
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
		
		gameContainer   = new DisplayObjectContainer();
		hudContainer    = new DisplayObjectContainer();
		screenContainer = new DisplayObjectContainer();
		popinContainer  = new DisplayObjectContainer();
		
		addChild(gameContainer);
		addChild(hudContainer);
		addChild(screenContainer);
		addChild(popinContainer);
		
		gameContainerAlignMode   = GameStageAlign.CENTER;
		hudContainerAlignMode    = GameStageAlign.TOP_LEFT;
		screenContainerAlignMode = GameStageAlign.CENTER;
		popinContainerAlignMode  = GameStageAlign.CENTER;
		
		addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
	}
	
	private function onAddToStage(event:Event):Void {
		parent.stage.addEventListener(Event.RESIZE, resize);
		resize();
	}
	
	private function onRemoveFromStage(event:Event):Void {
		parent.stage.removeEventListener(Event.RESIZE, resize);
	}
	
	/**
	 * Add child to gameContainer
	 * @param   displayObj
	 */
	public function addGameChild(displayObj:DisplayObject):Void {
		gameContainer.addChild(displayObj);
	}
	
	/**
	 * Remove child from gameContainer
	 * @param	displayObj
	 */
	public function removeGameChild(displayObj:DisplayObject):Void {
		gameContainer.removeChild(displayObj);
	}
	
	/**
	 * Add screen child to screenContainer
	 * @param   game
	 */
	public function addScreen(screen:DisplayObject):Void {
		screenContainer.addChild(screen);
	}
	
	/**
	 * Remove screen child from screenContainer
	 * @param	game
	 */
	public function removeScreen(screen:DisplayObject):Void {
		screenContainer.removeChild(screen);
	}
	
	/**
	 * Add popin child to popinContainer
	 * @param   game
	 */
	public function addPopin(popin:DisplayObject):Void {
		popinContainer.addChild(popin);
	}
	
	/**
	 * Remove popin child from popinContainer
	 * @param	game
	 */
	public function removePopin(popin:DisplayObject):Void {
		popinContainer.removeChild(popin);
	}
	
	/**
	 * Add hud child to hudContainer
	 * @param   game
	 */
	public function addHud(hud:DisplayObject):Void {
		hudContainer.addChild(hud);
	}
	
	/**
	 * Remove hud child from hudContainer
	 * @param	game
	 */
	public function removeHud(hud:DisplayObject):Void {
		hudContainer.removeChild(hud);
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
	
	private function setContainerAlignMode(container:DisplayObjectContainer, alignMode:GameStageAlign):Void {
		if (alignMode == GameStageAlign.CENTER || alignMode == GameStageAlign.LEFT || alignMode == GameStageAlign.RIGHT) {
			container.y = safeZone.height / 2;	
		} else if (alignMode == GameStageAlign.TOP || alignMode == GameStageAlign.TOP_LEFT || alignMode == GameStageAlign.TOP_RIGHT) {
			container.y = safeZone.y;
		} else if (alignMode == GameStageAlign.BOTTOM || alignMode == GameStageAlign.BOTTOM_LEFT || alignMode == GameStageAlign.BOTTOM_RIGHT) {
			container.y = safeZone.height;
		}
		
		if (alignMode == GameStageAlign.CENTER || alignMode == GameStageAlign.TOP || alignMode == GameStageAlign.BOTTOM) {
			container.x = safeZone.width / 2;
		} else if (alignMode == GameStageAlign.BOTTOM_LEFT || alignMode == GameStageAlign.LEFT || alignMode == GameStageAlign.TOP_LEFT) {
			container.x = safeZone.x;
		} else if (alignMode == GameStageAlign.RIGHT || alignMode == GameStageAlign.TOP_RIGHT || alignMode == GameStageAlign.BOTTOM_RIGHT) {
			container.x = safeZone.width;
		}
	}
	
	private function set_gameContainerAlignMode(alignMode:GameStageAlign):GameStageAlign {
		setContainerAlignMode(gameContainer, alignMode);
		return gameContainerAlignMode = alignMode;
	}
	
	private function set_hudContainerAlignMode(alignMode:GameStageAlign):GameStageAlign {
		setContainerAlignMode(hudContainer, alignMode);
		return hudContainerAlignMode = alignMode;
	}
	
	private function set_screenContainerAlignMode(alignMode:GameStageAlign):GameStageAlign {
		setContainerAlignMode(screenContainer, alignMode);
		return screenContainerAlignMode = alignMode;
	}
	
	private function set_popinContainerAlignMode(alignMode:GameStageAlign):GameStageAlign {
		setContainerAlignMode(popinContainer, alignMode);
		return popinContainerAlignMode = alignMode;
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
		setContainerAlignMode(gameContainer, gameContainerAlignMode);
		setContainerAlignMode(hudContainer, hudContainerAlignMode);
		setContainerAlignMode(popinContainer, popinContainerAlignMode);
		setContainerAlignMode(screenContainer, screenContainerAlignMode);
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