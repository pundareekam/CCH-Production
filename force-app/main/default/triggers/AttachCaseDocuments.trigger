trigger AttachCaseDocuments on CaseDocument__c (after insert) {
    List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();
    List<ContentDocument> cds = new List<ContentDocument>();
    for (CaseDocument__c c : Trigger.new) {
        if (c.DocumentId__c == 'share2contact') {
            System.debug('TR123: '+ TR_Cases_Share_2_Contact.shareTRCases2Contact());
        }
        else
        {
            ContentDocumentLink d = new ContentDocumentLink();
            ContentDocument a = new ContentDocument();
            d.ContentDocumentId = c.DocumentId__c;
            d.LinkedEntityId = c.Caseid__c;
            d.ShareType  = 'I';
            cdls.add(d);
            a.Id = c.DocumentId__c;
            a.Title = c.Title__c;
            cds.add(a);   
        }
    }
    try {
        insert cdls;
        update cds;
    } catch(DmlException e) {
        System.debug('An unexpected error has occurred: ' + e.getMessage());
    }	
    System.debug('inserted ContentDocumentLInks: ' + cdls.size());
    System.debug('Updated ContentDocuments: ' + cds.size());
}