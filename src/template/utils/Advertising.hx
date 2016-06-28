package template.utils;

import extension.admob.GravityMode;
import extension.admob.AdMob;

class Advertising {
	public static function init(bannerPosition:GravityMode):Void {
		if (Metadatas.application.advertising.sandbox) {
			AdMob.enableTestingAds();
		}

		#if ios
		AdMob.initIOS(Metadatas.application.advertising.bannerId, Metadatas.application.advertising.interstitialId, bannerPosition);
		#end

		#if android
		AdMob.initAndroid(Metadatas.application.advertising.bannerId, Metadatas.application.advertising.interstitialId, bannerPosition);
		#end

		AdMob.showBanner();
	}
}
