public class TR_Cases_Share_2_Contact {
    public static Integer shareTRCases2Contact() {
        Map<Id, Case> cases2Share = new Map<Id, Case>([Select Id,
                                                       Contact.User__r.Id,
                                                       Contact.User__r.Supervisor__c,
                                                       OwnerId,
                                                       Status                                                       
                                                       From Case
                                                       Where recordtypename__c = 'Tuition Reimbursement'
                                                       And Status = 'Sent for Supervisor Review (14)'
                                                       And createddate > LAST_WEEK]);
        System.debug('TR123: No Records found:'+cases2Share.size());   
        List<CaseShare> csShares = new List<CaseShare>([Select CaseId,
                                                        UserOrGroupId
                                                        From CaseShare
                                                        Where CaseId In :cases2Share.keyset()]);
        List<Case> cShares = new List<Case>();
        for (CaseShare cs : csShares) {
            if (cases2Share.containsKey(cs.CaseId))
                if (cs.UserOrGroupId == cases2Share.get(cs.CaseId).Contact.User__r.Id )
                   cases2Share.remove(cs.CaseId);
        }
        List<CaseShare> csInsert = new List<CaseShare>();
        for(Case c : cases2Share.Values()) {
            CaseShare csi = new CaseShare();
            csi.CaseId = c.Id;
            csi.UserOrGroupId = c.Contact.User__r.Id;
            csi.CaseAccessLevel = 'Edit';
            csInsert.add(csi);
            CaseShare csi1 = new CaseShare();
            if (c.Contact.User__r.Supervisor__c <> null ) {
                csi1.CaseId = c.Id;
                csi1.UserOrGroupId = c.Contact.User__r.Supervisor__c;
                csi1.CaseAccessLevel = 'Edit';
                csInsert.add(csi1);
            }
            System.debug('cs Share ' + csi);
        }
        
        try {
            if (csInsert.size() > 0)
                   insert csInsert;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        return csInsert.size();
    }   
    
}