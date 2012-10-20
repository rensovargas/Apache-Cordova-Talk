(function(){
    console.log("DEBUG");
    document.addEventListener('deviceready', onDeviceReady, false);

    function onDeviceReady(){
        var debuglink = document.querySelector(".debug-link");
        debuglink.addEventListener("touchend", debugLinkHandler);
    }

    function debugLinkHandler(e){
        navigator.notification.alert("Debug Message", function(){}, "Debug", "Done");
    }

})();