package template.utils.mobile;

import openfl.net.URLRequest;
import openfl.Lib;

class AppRating {
	private static inline var IOS_BASE_LINK:String = 'itms://itunes.apple.com/us/app/apple-store/id';

	public static function request():Void {
		iosRequest();

	}

	private static function iosRequest():Void {
		#if ios
		if (Metadatas.application.appleAppId == '-') {
			throw appIdNotFoundException();
		}
		Lib.getURL(new URLRequest(IOS_BASE_LINK + Metadatas.application.appleAppId));
		#end
	}

	private static function androidRequest():Void {
		#if android
		// todo
		#end
	}

	private static function appIdNotFoundException():String {
		return 'AppRating.hx : appId is not configured, set it in assets/config/application.json file';
	}
}
