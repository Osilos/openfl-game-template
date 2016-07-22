package template.utils.mobile;

import extension.apprating.AppRating;

class AppRating {
	public static function redirectToStore():Void {
		iosRequest();
		androidRequest();
	}

	private static function iosRequest():Void {
		#if ios
		if (Metadatas.configuration.appleAppId == null) {
			throw appIdNotFoundException();
		}
		extension.apprating.AppRating.redirectToStore(Metadatas.configuration.appleAppId);
		#end
	}

	private static function androidRequest():Void {
		#if android
		if (Metadatas.configuration.androidPackageName == null) {
			throw appIdNotFoundException();
		}
		extension.apprating.AppRating.redirectToStore(Metadatas.configuration.androidPackageName);
		#end
	}

	private static function appIdNotFoundException():String {
		return 'AppRating.hx : appId/androidPackageName is not configured, set it in assets/config/configuration.json file';
	}
}
