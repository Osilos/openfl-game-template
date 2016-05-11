package template.utils.preloader;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Preloader;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.Lib;

@:bitmap("assets/preloader/logo.png") class Splash extends BitmapData {}

/**
 * ...
 * @author Flavien
 */
class CustomePreloader extends NMEPreloader
{	
	private static inline var preloadBackgroundColor:Int = 0x87CEEB;
	private static inline var baseBackgroundColor:Int = 0xFFFFFF;
	
	private var splash:Bitmap;
    private var splashSize:Point = new Point(500,500);
	
	public function new() 
	{
		super();
		
		createSplashImage();
		centerSplashImage();
		
		hideOutline();
		changeBackgroundColor(preloadBackgroundColor);
		
		addEventListener(Event.COMPLETE, onComplete);
	}
	
	private function changeBackgroundColor (color:Int) : Void {
		Lib.current.stage.color = color;
	}
	
	private function hideOutline () : Void {
		outline.visible = false;
	}
	
	private function createSplashImage () : Void {
		splash = new Bitmap(new Splash(Std.int(splashSize.x), Std.int(splashSize.y)));
        splash.smoothing = true;
        addChild(splash);
	}
	
	private function centerSplashImage () : Void {
		splash.x = Lib.current.stage.width / 2 - splashSize.x / 2;
	}
	
	override public function onUpdate(bytesLoaded:Int, bytesTotal:Int):Void 
	{
		centerSplashImage();
		trace(bytesLoaded + " / " + bytesTotal);
	}
	
	public function onComplete (event:Event):Void {
        // restore original background color
		changeBackgroundColor(baseBackgroundColor);
		trace("LOADING FINISH");
    }
	
}