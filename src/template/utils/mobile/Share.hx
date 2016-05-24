package template.utils.mobile;

import extension.share.Share;

class Share {
	public static function request(?text:String, ?subject:String, ?email:String):Void {
		text = text == null ? Metadatas.application.shareInformation.text : text;
		subject = subject == null ? Metadatas.application.shareInformation.subject : subject;
		email = email == null ? Metadatas.application.shareInformation.email : email;

		extension.share.Share.share(text, subject, '', '', email, '');
	}
}
