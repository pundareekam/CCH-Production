@isTest
private class FlowLaunchV2_VFC_TEST{
  @isTest static void simpleTest() {
    FlowLaunchV2_VFC fl = new FlowLaunchV2_VFC();
    
    if(fl.flowList != null) System.debug('YAY');
    if(fl.CurrentUser != null) System.debug('YAY');
    if(fl.CurrentUserContact != null) System.debug('YAY');
    if(fl.ScheduleLinkParams != null) System.debug('YAY');
    if(fl.flowsList  != null) System.debug('YAY');
      
    FlowLaunchV2_VFC.Flow ffl = new FlowLaunchV2_VFC.Flow(new Map<String, Object>{ 'Title' => 'test' , 'Url' => 'test', 'Image' => 'test' });
    if(ffl != null) System.debug('YAY');
  }
}