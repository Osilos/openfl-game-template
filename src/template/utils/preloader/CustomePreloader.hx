package template.utils.preloader;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Preloader;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.Lib;
import openfl.net.URLRequest;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import template.utils.localization.Localization;

@:bitmap("assets/preloader/logo.png") class Splash extends BitmapData {}

/**
 * ...
 * @author Flavien
 */
class CustomePreloader extends NMEPreloader
{	
	private static inline var preloadBackgroundColor:Int = 0x87CEEB;
	private static inline var baseBackgroundColor:Int = 0xFFFFFF;
	
	private static inline var basePercentText:String = "0%";
	private static inline var baseLoadingTextLabel:String = "loading";
	
	private static inline var TOP_OFFSET:Float = 25;
	
	private static var website = "http://www.openfl.org/";
	
	private var screenSize:Point = new Point();
	
	private var splash:Bitmap;
    private var splashSize:Point = new Point(500, 500);
	
	private var percentText:TextField;
	private var loadingText:TextField;
	
	public function new() 
	{
		super();
		
		Localization.init();
		
		updateScreenSize();
		
		createSplashImage();
		centerSplashImage();
		
		percentText = createTextField(basePercentText);
		loadingText = createTextField(Localization.getText(baseLoadingTextLabel));
		
		addChild(percentText);
		addChild(loadingText);
		
		placeTopLeftCorner(loadingText, TOP_OFFSET);
		placeTopLeftCorner(percentText, TOP_OFFSET * 2);
		
		hideOutline();
		//changeBackgroundColor(preloadBackgroundColor);
		
		
		Lib.current.stage.addEventListener(Event.RESIZE, onResize);
        Lib.current.stage.addEventListener(Event.ENTER_FRAME, onFrame);
        Lib.current.stage.addEventListener(MouseEvent.CLICK, gotoWebsite, false, 0, true);
		
		addEventListener(Event.COMPLETE, onComplete);
	}
	
	override public function onUpdate(bytesLoaded:Int, bytesTotal:Int):Void 
	{
		var percent:Float = MathUtils.getPercent(bytesLoaded, bytesTotal);
		setPercentText(Std.string(Math.ceil(percent)));
	}
	
	public function onComplete (event:Event):Void {
		changeBackgroundColor(baseBackgroundColor);
		
		Lib.current.stage.removeEventListener(Event.RESIZE, onResize);
        Lib.current.stage.removeEventListener(Event.ENTER_FRAME, onFrame);
        Lib.current.stage.removeEventListener(MouseEvent.CLICK, gotoWebsite);
    }
	
	private function setPercentText (text:String) : Void {
		percentText.text = text + " %";
	}
	
	private function gotoWebsite(event:MouseEvent):Void
    {
        Lib.getURL(new URLRequest (website));
    }
	
	private function onResize (event:Event) : Void {
		updatePosition();
	}
	
	private function onFrame (event:Event) : Void {
		updatePosition();
	}
	
	private function updatePosition () : Void {
		updateScreenSize();
		centerSplashImage();
		placeTopLeftCorner(loadingText, TOP_OFFSET);
		placeTopLeftCorner(percentText, TOP_OFFSET * 2);
	}
	
	private function updateScreenSize () : Void {
		screenSize.setTo(Lib.current.stage.width, Lib.current.stage.height);
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
		splash.x = screenSize.x / 2 - splashSize.x / 2;
	}
	
	private function placeTopLeftCorner (text:TextField, topOffset:Float) : Void {
		text.x = 50;
		text.y = topOffset + text.height;
	}
	
	private function createTextField (?text:String = null) : TextField {
		var textField = new TextField();
        textField.embedFonts = true;
        textField.selectable = false;
		textField.text = text;
		textField.textColor = 0xFFFFFF;
		textField.height = 20;
		textField.width = 50;
		textField.autoSize = TextFieldAutoSize.CENTER;
		
		return textField;
	}
}