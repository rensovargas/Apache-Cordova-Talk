/*global cordova:true*/

(function(app){
    "use strict";

    app.plugins.Print = function(){
     
        function print(data){
            cordova.exec(null, null, 'Print', 'print', [data]);
        }
         
        return {
            print: print
        };
    };

})(app);