package template.utils.debug;

import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.display.DisplayObjectContainer;
import openfl.display.Graphics;
import openfl.geom.Point;

class Debug {
	private static var debugPoints:Array<Graphics> = new Array<Graphics>();
	private static var debugTexts:Array<Graphics> = new Array<Graphics>();
	private static var container:DisplayObjectContainer;

	public static function initContainer(container:DisplayObjectContainer):Void {
		this.container = container;
	}

	public static function addDebugPointAt(position:Point, color:Int = 0xFF0000):Graphics {
		if (container == null) {
			throwContainerNotInitializedException();
		}
		var debugPoint = new Graphics();
		debugPoint.beginFill(color);
		debugPoint.drawCircle(0, 0, 5);
		debugPoint.moveTo(position.x, position.y);
		debugPoints.push(debugPoint);
		container.addChild(debugPoint);
		return debugPoint;
	}

	public static function addDebugTextAt(position:Point, text:String, color:Int = 0xff1010):TextField {
		if (container == null) {
			throwContainerNotInitializedException();
		}
		var text = new TextField();
		text.selectable = false;
		text.defaultTextFormat = new TextFormat("_sans", 12, color);
		text.x = position.x;
		text.y = position.y;
		container.addChild(text);
		return text;
	}

	public static function removeDebugElements():Void {
		for (debugPoint in debugPoints) {
			debugPoints.splice(debugPoints.indexOf(debugPoint), 1);
			container.removeChild(debugPoint);
		}

		for (debugText in debugTexts) {
			debugPoints.splice(debugPoints.indexOf(debugText), 1);
			container.removeChild(debugText);
		}
	}

	private static function throwContainerNotInitializedException():Void {
		throw 'Debug.hx : Container has not been initialized, use initContainer(container:DisplayObjectContainer):Void';
	}
}
