@isTest
public class TR_Cases_Share_2_Contact_TEST {
    
    static testMethod void simpleTest() {
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
            Contact contact = new Contact(FirstName = 'Test First Name', LastName = 'Test Last name');
            insert contact;
            List<Case> cs = new List<Case>();
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Grievance']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    Course_One_Beginning_Date__c = Date.valueOf('2020-12-30'),
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    Course_One_Beginning_Date__c = Date.valueOf('2020-03-30'),
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    Course_One_Beginning_Date__c = Date.valueOf('2020-06-30'),
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    Course_One_Beginning_Date__c = Date.valueOf('2020-09-30'),
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                  
                    Status = 'Sent for Supervisor Review (14)',
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    
                    Status = 'Sent for Supervisor Review (14)',
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Tuition_Reimbursement_Case_Status__c = 'Approved - Grades Submitted',
                    Status = '45 Day Awaiting Grade',
                    ContactId = contact.Id
                ));
            }
            
            for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'EPO Incident']) {
                cs.add(new Case(
                    RecordTypeID = rt.Id,
                    Status = 'New',
                    ContactId = contact.Id
                ));
            }
            
            insert cs;
        
            TR_Cases_Share_2_Contact.shareTRCases2Contact();
            System.debug('UpdateCaseSubject Ran Successfully');
        }
    }
    
}