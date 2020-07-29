@isTest
public class TriggerFactory_TEST {

	public static testmethod void happyPath() {
		insert new OrgAdminSettings__c(SetupOwnerId = UserInfo.getOrganizationId(),DebugOn__c = true);
		TestHelper th = new TestHelper();
		th.createAdminUser();
		System.runAs(th.Admin) {
			Test.startTest();
			DebugLog__c dbl = new DebugLog__c(Log__c = 'This is a test');
			insert dbl;
			update dbl;
			delete dbl;
			undelete dbl;
			Test.stopTest();
		}
	}

	public static testmethod void triggersOff() {
		insert new OrgAdminSettings__c(SetupOwnerId = UserInfo.getOrganizationId(),TurnAllTriggersOff__c = true,DebugOn__c = true);
		TestHelper th = new TestHelper();
		th.createAdminUser();
		System.runAs(th.Admin) {
			Test.startTest();
			DebugLog__c dbl = new DebugLog__c(Log__c = 'This is a test');
			insert dbl;
			update dbl;
			delete dbl;
			undelete dbl;
			Test.stopTest();
		}
	}

	public static testmethod void objectOff() {
		insert new OrgAdminSettings__c(SetupOwnerId = UserInfo.getOrganizationId(),DebugOn__c = true);
		insert new Trigger_Switch__c(Name = 'DebugLog__c',Enabled__c = false);
		TestHelper th = new TestHelper();
		th.createAdminUser();
		System.runAs(th.Admin) {
			Test.startTest();
			DebugLog__c dbl = new DebugLog__c(Log__c = 'This is a test');
			insert dbl;
			update dbl;
			delete dbl;
			undelete dbl;
			Test.stopTest();
		}
	}

	public static testmethod void fringeCases() {
		insert new OrgAdminSettings__c(SetupOwnerId = UserInfo.getOrganizationId(),DebugOn__c = true);
		insert new Trigger_Switch__c(Name = 'DebugLog__c',Enabled__c = false);
		TestHelper th = new TestHelper();
		th.createAdminUser();
		System.runAs(th.Admin) {
			Test.startTest();
			TriggerFactory.switchForTest = true;
			TriggerFactory.convertObjectNameToHandlerName('a'.repeat(41));
			TriggerFactory.switchForTest = false;
			TriggerFactory.convertObjectNameToHandlerName(null);
			TriggerFactory.initialize(ApexClass.SObjectType);
			Test.stopTest();
		}
	}
}