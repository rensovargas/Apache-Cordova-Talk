(function(app){
    
    app.plugins.Screenshot = function(){
     
        function grab(section){
            cordova.exec(null, null, 'Screenshot', 'grab', [section]);
        }
         
        return {
            grab: grab
        };
    };

})(app);