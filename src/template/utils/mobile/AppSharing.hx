package template.utils.mobile;

import extension.share.AppSharing;

class AppSharing {
	public static function openShareDialog(?text:String, ?subject:String, ?email:String):Void {
		text = text == null ? Metadatas.application.shareInformation.text : text;
		subject = subject == null ? Metadatas.application.shareInformation.subject : subject;
		email = email == null ? Metadatas.application.shareInformation.email : email;

		extension.share.AppSharing.share(text, subject, '', '', email, '');
	}
}
