// window.plugins.emailComposer

(function(app){
	"use strict";

	app.plugins = app.plugins || {};
	app.plugins.EmailComposer = function() {
		this.resultCallback = null; // Function
	};

	app.plugins.EmailComposer.ComposeResultType = {
		Cancelled:0,
		Saved:1,
		Sent:2,
		Failed:3,
		NotSent:4
	};

	// showEmailComposer : all args optional

	app.plugins.EmailComposer.prototype.showEmailComposer = function(subject,body,toRecipients,ccRecipients,bccRecipients,bIsHTML,pdfSettings) {
		var args = {};
		if(toRecipients){
			args.toRecipients = toRecipients;
		}
		if(ccRecipients){
			args.ccRecipients = ccRecipients;
		}
		if(bccRecipients){
			args.bccRecipients = bccRecipients;
		}
		if(subject){
			args.subject = subject;
		}
		if(body){
			args.body = body;
		}
		if(bIsHTML){
			args.bIsHTML = bIsHTML;
		}
		if(pdfSettings){
			args.pdfSettings = pdfSettings;
		}
			
		cordova.exec(this.resultCallback, null, "EmailComposer", "showEmailComposer", args);
	};

	// this will be forever known as the orch-func -jm
	app.plugins.EmailComposer.prototype.showEmailComposerWithCB = function(cbFunction,subject,body,toRecipients,ccRecipients,bccRecipients,bIsHTML,pdfSettings) {
		this.resultCallback = cbFunction;
		this.showEmailComposer.apply(this,[subject,body,toRecipients,ccRecipients,bccRecipients,bIsHTML,pdfSettings]);
	};

	app.plugins.EmailComposer.prototype._didFinishWithResult = function(res) {
		this.resultCallback(res);
	};

})(app);
