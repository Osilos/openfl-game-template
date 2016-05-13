package template.utils.debug;

import haxe.Timer;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class DebugInfo extends TextField
{
	private var times:Array<Float>;
	private var fps:Int;
	private var memoryConsumptionMB:Float = 0;
	private var memoryConsumptionPeakMB:Float = 0;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();
		this.x = x;
		this.y = y;

		selectable = false;
		defaultTextFormat = new TextFormat("_sans", 12, color);
		width = 150;
		height = 70;
		times = [];

		addEventListener(Event.ENTER_FRAME, updateInfo);
	}

	private function updateInfo(event:Dynamic):Void {
		updateFrameCounter();
		updateMemoryConsumptionMB();
		displayInfos();
	}

	private function updateFrameCounter():Void {
		var now:Float = Timer.stamp();
		times.push(now);

		while (times[0] < now - 1) {
			times.shift();
		}

		fps = times.length;
	}

	private function updateMemoryConsumptionMB():Void {
		memoryConsumptionMB = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;
		if (memoryConsumptionMB > memoryConsumptionPeakMB) {
			memoryConsumptionPeakMB = memoryConsumptionMB;
		}
	}

	private function displayInfos():Void {
		if (visible) {
			text = (
				"FPS: " + fps + "\n" +
				"MEM: " + memoryConsumptionMB + " MB\n" +
				"MEM peak: " + memoryConsumptionPeakMB + " MB"
			);
		}
	}

}