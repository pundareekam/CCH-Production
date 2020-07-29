@isTest
private class Pay_Accrual_Error_Flow_VFC_TEST {
	@isTest static void simpleTest() {
		Pay_Accrual_Error_Flow_VFC vfc = new Pay_Accrual_Error_Flow_VFC();
		System.debug(vfc.headerText);
		System.debug(vfc.showUpload);
		System.debug(vfc.redirectToCase);
	}
}