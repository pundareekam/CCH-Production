@isTest
private class ComplianceCaseController_TEST {
    
    static testMethod void simpleTest() {
    User u = [SELECT Id FROM User WHERE UserName = 'pundareekam.kudikala@cookcountyhhs.org'];
    Case testCase = new Case();
    
        System.runAs(u){
            testCase.Contact__c = u.Id;
            ApexPages.StandardController sc = new ApexPages.StandardController(testCase);
            ComplianceCaseController ccc = new ComplianceCaseController(sc);
            PageReference ref = new PageReference('/apex/NewComplianceCaseForm');
            test.setCurrentPage(ref);
            ccc.save();
            User u1 = new User();
            u1 = ccc.CurrentUser;
            ccc.updateContact(); 
            testCase.Contact__c = null;
            ccc.updateContact();   
            
            
            Counter__C counter = new Counter__c();
            counter.Count__c = '0';
            counter.Name = 'ComplianceCaseNumber';
            insert counter;
            
            ccc.incrementAndAddCounter();
            counter.Count__c = '10000';
            update counter;
            ccc.incrementAndAddCounter();
        }
 
  }
}