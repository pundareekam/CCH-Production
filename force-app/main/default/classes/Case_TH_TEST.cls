@isTest
private class Case_TH_TEST {
    
    @isTest static void simpleTest() {
        
        insert new OrgAdminSettings__c();
        TestHelper th = new TestHelper();
        
        th.UserProfileNames = new List<String>{'Cook County Health Employee','Cook County Health Standard User'};
            
            th.createAdminUser(false);
        th.createUserRecords(false);
        
        
        
        th.Admin.UnionID__c = 'a';
        th.Admin.UnionDescription__c = 'abc';
        
        for(User u:th.UserRecords) {
            u.ManagerId = th.Admin.Id;
            u.UnionID__c = th.Admin.UnionID__c;
            u.UnionDescription__c = th.Admin.UnionDescription__c;
        }
        
        insert th.UserRecords;
        
        th.Admin.ManagerId = th.UserRecords[0].Id;
        
        insert th.Admin;
        
        
        System.runAs(th.Admin) {
            
            List<Case> cs = new List<Case>();
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Grievance']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New'
                ));
            }   
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'EPO Incident']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    EPO_Complaint_Employee__c = th.UserRecords[0].Id,
                    EPO_Date_Entered__c = Date.valueOf('2020-02-29')
                ));
            }
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'EPO Incident']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    EPO_Date_Entered__c = Date.valueOf('2020-02-29')
                ));
            }            
            
            insert cs;
            update cs;
            
            for(Case c:cs) c.Step_1_Comments__c = 'something';
            
            try { update cs; } catch(Exception e) {}
            
            //Case_TH.populateTeamMembersMap();
            Case_TH.populateCaseTeamRoleMap();
            System.debug(Case_TH.getRecordTypeIdToName());
            System.debug(Case_TH.getTeamMembersMap()+'');
            System.debug(Case_TH.getCaseTeamRoleMap());
            System.debug(Case_TH.getCasesAlreadyUpdated());
        }
    }
}