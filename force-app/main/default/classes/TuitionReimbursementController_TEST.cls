@isTest
public class TuitionReimbursementController_TEST {
    @isTest static void simpleTest() {
        Contact contact = new Contact(FirstName = 'Test First Name', LastName = 'Test Last name');
        insert contact;
        List<Case> cs = new List<Case>();
        
        for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Tuition Reimbursement']) {
            cs.add(new Case(
                RecordTypeID = rt.Id,
                Status = 'HR Review Pending',
                ContactId = contact.Id
            ));
            cs.add(new Case(
                RecordTypeID = rt.Id,
                Status = 'New',
                ContactId = contact.Id
            ));
        }
        insert cs;
        
        Pagereference testPage = Page.New_TuitionReimbursement_VFP;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id',String.valueOf(cs.get(0).Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(cs.get(0));
        TuitionReimbursementController trc = new TuitionReimbursementController(sc);
        trc.save();
        
        Pagereference testPage1 = Page.New_TuitionReimbursement_VFP;
        Test.setCurrentPage(testPage1);
        testPage1.getParameters().put('Id',String.valueOf(cs.get(1).Id));
        ApexPages.StandardController sc1 = new ApexPages.StandardController(cs.get(1));
        TuitionReimbursementController trc1 = new TuitionReimbursementController(sc1);
        trc1.save();
        

    }
}