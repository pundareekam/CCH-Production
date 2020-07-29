@isTest
private class FlowLaunch_VFC_TEST {
	@isTest static void simpleTest() {
		FlowLaunch_VFC fl = new FlowLaunch_VFC();
		if(fl.flowsList != null) System.debug('YAY');
		if(fl.CurrentUser != null) System.debug('YAY');
	}
}