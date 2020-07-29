({
    navigateHomePage : function(event) {
        if(event.getParam("status") === "FINISHED") {
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/home/home.jsp"
            });
            urlEvent.fire();
        }
        
    }
})