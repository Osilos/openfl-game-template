package template.utils.debug;

import openfl.text.TextFieldAutoSize;
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

	public static function initContainer(container:DisplayObjectContainer):Void {
		Debug.container = container;
	}

	public static function addDebugPointAt(position:Point, color:Int = 0xFF0000):Sprite {
		if (container == null) {
			throwContainerNotInitializedException();
		}
		var debugPoint = new Sprite();
		debugPoint.graphics.beginFill(color);
		debugPoint.graphics.drawCircle(0, 0, 2);
		debugPoint.x = position.x;
		debugPoint.y = position.y;
		debugPoints.push(debugPoint);
		container.addChild(debugPoint);
		return debugPoint;
	}

	public static function addDebugTextAt(position:Point, text:String, color:Int = 0xFF000):TextField {
		if (container == null) {
			throwContainerNotInitializedException();
		}
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
		trace(debugPoints);
		trace(debugTexts);
	}

	private static function throwContainerNotInitializedException():Void {
		throw 'Debug.hx : Container has not been initialized, use initContainer(container:DisplayObjectContainer):Void';
	}
}
