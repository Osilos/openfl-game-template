package template.utils.mobile;

import extension.apprating.AppRating;

class AppRating {
	public static function redirectToStore():Void {
		iosRequest();
		androidRequest();
	}

	private static function iosRequest():Void {
		#if ios
		if (Metadatas.application.appleAppId == null) {
			throw appIdNotFoundException();
		}
		extension.apprating.AppRating.redirectToStore(Metadatas.application.appleAppId);
		#end
	}

	private static function androidRequest():Void {
		#if android
		if (Metadatas.application.androidPackageName == null) {
			throw appIdNotFoundException();
		}
		extension.apprating.AppRating.redirectToStore(Metadatas.application.androidPackageName);
		#end
	}

	private static function appIdNotFoundException():String {
		return 'AppRating.hx : appId/androidPackageName is not configured, set it in assets/config/application.json file';
	}
}
