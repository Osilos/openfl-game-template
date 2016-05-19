package template.utils.debug;

import openfl.display.Sprite;
import openfl.display.DisplayObject;
import template.utils.debug.Debug;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.display.DisplayObjectContainer;
import openfl.display.Graphics;
import openfl.geom.Point;

class Debug {
	private static var debugPoints:Array<Sprite> = new Array<Sprite>();
	private static var debugTexts:Array<TextField> = new Array<TextField>();
	private static var container:DisplayObjectContainer;

	public static function initDefaultContainer(container:DisplayObjectContainer):Void {
		Debug.container = container;
	}

	public static function addDebugPointAt(position:Point, color:Int = 0xFF0000, ?sourceContainer:DisplayObjectContainer):Sprite {
		var container:DisplayObjectContainer = getAvailableContainer(sourceContainer);
		var debugPoint = new Sprite();
		debugPoint.graphics.beginFill(color);
		debugPoint.graphics.drawCircle(0, 0, 20);
		debugPoint.x = position.x;
		debugPoint.y = position.y;
		debugPoints.push(debugPoint);
		container.addChild(debugPoint);
		return debugPoint;
	}

	public static function addDebugTextAt(position:Point, text:String, color:Int = 0xFF000, ?sourceContainer:DisplayObjectContainer):TextField {
		var container:DisplayObjectContainer = getAvailableContainer(sourceContainer);
		var textField = new TextField();
		textField.selectable = false;
		textField.defaultTextFormat = new TextFormat("_sans", 12, color);
		textField.x = position.x;
		textField.y = position.y;
		textField.text = text;
		textField.width = 9999;
		debugTexts.push(textField);
		container.addChild(textField);
		return textField;
	}

	public static function removeDebugElements():Void {
		var elementsOfElements:Array<Array<Dynamic>> = [debugPoints, debugTexts];

		for (elements in elementsOfElements) {
			var elementsToRemoveCount:Int = elements.length;
			for (i in 0...elementsToRemoveCount) {
				var inversedIndex:Int = (elementsToRemoveCount - 1) - i;
				var element:Dynamic = elements[inversedIndex];
				elements.splice(inversedIndex, 1);
				container.removeChild(element);
			}
		}
	}

	private static function getAvailableContainer(sourceContainer:DisplayObjectContainer):DisplayObjectContainer {
		if (sourceContainer != null) {
			return sourceContainer;
		}
		if (container != null) {
			return container;
		}
		throw containerNotFoundException();
	}

	private static function containerNotFoundException():String {
		return (
			'Debug.hx : Container to add debug element was not found, ' +
			'pass container in method argument or use initContainer(container:DisplayObjectContainer):Void'
		);
	}
}
