/*
	~Covers~
	UserTrigger
	User_TH
	UserMapping
*/
@isTest
private class User_TH_TEST {
	@isTest static void simpleTest() {
		insert new OrgAdminSettings__c();
		TestHelper th = new TestHelper();
		th.UserProfileNames = new List<String>{'System Administrator','CCHHS Employee','CCHHS Standard User'};
		th.createUserRecords();
		update [SELECT Id FROM User LIMIT :th.UserProfileNames.size()];
	}
}