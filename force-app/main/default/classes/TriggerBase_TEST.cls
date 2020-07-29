@isTest
public class TriggerBase_TEST {
	public static testmethod void simpleTest() {
		TestHelper th = new TestHelper();
		th.runSetup();
		System.runAs(th.Admin) {
			Test.startTest();
			TriggerBase tb = new TriggerBase();
			tb.setupBefore();
			tb.beforeInsert();
			tb.beforeUpdate();
			tb.beforeDelete();
			tb.setupAfter();
			tb.afterInsert();
			tb.afterUpdate();
			tb.afterDelete();
			tb.afterUndelete();
			tb.andFinally();
			List<Document> docs = new List<Document>{new Document(
				Body = Blob.valueOf('Some Text'),
				ContentType = 'application/pdf',
				DeveloperName = 'my_document',
				IsPublic = true,
				Name = 'My Document',
				FolderId = UserInfo.getUserId(),
				Description = 'Testy Testerton'
			)};
			tb.bulkUpserts.addAll((List<SObject>)docs);
			tb.bulkDML();
			tb.bulkDML();
			tb.bulkDeletes.addAll(tb.bulkUpserts);
			tb.bulkDML();
			Test.stopTest();
		}
	}
}