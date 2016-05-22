package template.utils.mobile;

import extension.share.Share;

class Share {
	public static function execute():Void {
		extension.share.Share.share(
			Metadatas.application.shareInformation.text,
			Metadatas.application.shareInformation.subject,
			Metadatas.application.shareInformation.image,
			'',
			Metadatas.application.shareInformation.email,
			Metadatas.application.shareInformation.url
		);
	}
}
