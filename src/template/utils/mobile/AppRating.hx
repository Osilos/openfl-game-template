package template.utils.mobile;

import openfl.net.URLRequest;
import openfl.Lib;

class AppRating {
	private static inline var IOS_LINK:String = 'itms://itunes.apple.com/us/app/apple-store/id';
	private static inline var ANDROID_LINK:String = 'market://details?id=';

	public static function execute():Void {
		iosRequest();
		androidRequest();
	}

	private static function iosRequest():Void {
		#if ios
		if (Metadatas.application.appleAppId == null) {
			throw appIdNotFoundException();
		}
		Lib.getURL(new URLRequest(IOS_LINK + Metadatas.application.appleAppId));
		#end
	}

	private static function androidRequest():Void {
		// todo
		#if android
		if (Metadatas.application.androidPackageName == null) {
			throw appIdNotFoundException();
		}
		Lib.getURL(new URLRequest(ANDROID_LINK + Metadatas.application.androidPackageName));
		#end
	}

	private static function appIdNotFoundException():String {
		return 'AppRating.hx : appId is not configured, set it in assets/config/application.json file';
	}
}
