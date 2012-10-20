/*global cordova:true*/

(function(app){
    "use strict";

    document.addEventListener('deviceready', documentLoad,  false);

    function documentLoad(e){
        document.querySelector(".print").addEventListener("touchend", printTouchHandler);
        document.querySelector(".email").addEventListener("touchend", emailTouchHandler);    
    }

    function printTouchHandler(e){
        e.preventDefault();
        
        var print = new app.plugins.Print();
        print.print();
    }

    function emailTouchHandler(e){
        e.preventDefault();
        var email = new app.plugins.EmailComposer();
        //email.showEmailComposer("Email Plugin Demo");

        email.showEmailComposerWithCB(function(data){
            var message;
            if (data === "0"){
                message = "Cancelled";
            }else if(data === "1"){
                message = "Saved";
            }else if(data === "2"){
                message = "Sent";
            }else if(data === "3"){
                message = "Failed";
            }else if(data === "4"){
                message = "NotSent";
            }
            navigator.notification.alert(message, function(){}, "Mail Action", "Done");
        }, "Email Demo");
        
    }

})(app);