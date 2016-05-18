package template.utils.game;
import openfl.Lib;
import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import template.utils.game.CollisionHandler;
import template.utils.game.DisplayObjectHandler;

/**
 * ...
 * @author Théo Sabattié
 */
class CollisionHandler extends DisplayObjectHandler
{
	private static var gameLoopAttached:Bool 	    = false;
	private static var handlers:Array<CollisionHandler> = [];
	private static var tagToHandlers:Map<String, Array<CollisionHandler>> = new Map();
	private static var EMPTY_ARRAY:Array<CollisionHandler> = [];

	
	private static function gameLoop(event:Event):Void {
		for (handler in handlers) {
			handler.handleCollisions();
		}
	}
	
	private static function getCollidersWithTag(tag:String):Array<CollisionHandler> 
	{
		return (tagToHandlers.exists(tag)) ? tagToHandlers.get(tag) : EMPTY_ARRAY;
	}
	
	private static function addHandler(handler:CollisionHandler):Void {
		handlers.push(handler)
		tagToHandlers.get(handler.tag).push(handler); // TODO : vérifier que la liste existe sinon la créer
	}
	
	private static function removeHandler(handler:CollisionHandler):Void {
		handlers.remove(handler);
		tagToHandlers.get(handler.tag).remove(handler); // TODO : vérifier que la liste existe sinon, générer une erreur
	}
	
	
	private var eventDispatcher:EventDispatcher = new EventDispatcher();
	private var tag:String;
	private var targetCollisionTags:Array<String> = [];
	private var collidersEntered:Array<CollisionHandler> = [];

	
	public function new(target:DisplayObject, tag:String) 
	{
		super(target);
		
		this.tag = tag;
		
		if (!gameLoopAttached) {
			Lib.current.stage.addEventListener(Event.ENTER_FRAME, gameLoop);
			gameLoopAttached = true;
		}
	}
	
	override function onAddToStage(?e:Event = null):Void 
	{
		addHandler(this);
		//TODO : vérifier les collisions
	}
	
	override function onRemoveFromStage(e:Event):Void 
	{
		removeHandler(this);
		//TODO : cleaner les listes sur l'instance
	}
	
	private function handleCollisions():Void 
	{
		handleCollisionsEnter();
		handleCollisionsExit();
	}
	
	
	private function handleCollisionsEnter():Void {
		for (tag in targetCollisionTags) {
			getCollidersWithTag(tag);
		}
		
		
		for (handler in handlers) {
			if (handler.target != target && collidersEntered.indexOf(handler.target) == -1) {
				if (target.hitTestObject(handler.target)) {
					onCollisionEnter(handler);
				}
			}
		}
	}
	
	private function onCollisionEnter(collider:CollisionHandler):Void 
	{
		collidersEntered.push(collider);
		eventDispatcher.dispatchEvent(new CollisionEvent(CollisionEvent.COLLISION_ENTER, this, collider))
	}
	
	private function handleCollisionsExit():Void {
		for (collider in collidersEntered) {
			if (!collider.target.hitTestObject(target)) {
				onCollisionExit(collider);
			}
		}
	}
	
	private function onCollisionExit(collider:CollisionHandler):Void {
	{
		collidersEntered.remove(collider);
		eventDispatcher.dispatchEvent(new CollisionEvent(CollisionEvent.COLLISION_EXIT, this, collider));
	}
	
}