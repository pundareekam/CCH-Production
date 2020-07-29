@isTest
public class AttachCaseDocuments_TEST {
    static testMethod void simpleTest() {
        List<CaseDocument__c> cds = new List<CaseDocument__c>();
        cds.add(new CaseDocument__c(DocumentId__c = 'share2contact'));
       
        List<Case> cs = new List<Case>();
        for(RecordType rt:[SELECT Id FROM RecordType WHERE SObjectType = 'Case' And Name = 'Grievance']) {
            cs.add(new Case(
                RecordTypeID = rt.Id,
                Status = 'New'
            ));
        }
        insert cs;
        
        //Create Document
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Test Document';
        cv.PathOnClient = 'TestDocument.pdf';
        cv.VersionData = Blob.valueOf('Test Content');
        cv.IsMajorVersion = true;
        Insert cv;
        
        //Get Content Version
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
        System.assertEquals(cvList.size(), 1);
        
        //Get Content Documents
        List<ContentDocument> cdList = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        System.assertEquals(cdList.size(), 1);
        
        cds.add(new CaseDocument__c( DocumentId__c = String.valueOf(cdList.get(0).Id) , Caseid__c = cs.get(0).Id ));
        
        insert cds;
        
        
    }
    
}