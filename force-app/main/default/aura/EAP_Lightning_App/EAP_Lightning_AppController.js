({
  init : function (cmp) {
    var flow = cmp.find("flowData");
    flow.startFlow("EAP_Flow");
  },
    
  statusChange : function(component, event, helper) {
      
      helper.navigateHomePage(event);
    
  }
})