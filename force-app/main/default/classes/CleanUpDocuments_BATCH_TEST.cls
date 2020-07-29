@isTest
private class CleanUpDocuments_BATCH_TEST {
	@isTest static void simpleTest() {
		CleanUpDocuments_BATCH cud = new CleanUpDocuments_BATCH();
		cud.execute(null,null);
		cud.execute(null);
	}
}