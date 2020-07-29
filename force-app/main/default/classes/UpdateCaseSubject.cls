public without sharing class UpdateCaseSubject {
    
    public UpdateCaseSubject(List<Case> cases ) {
        for (Case c : cases) {
            if (c.RecordTypeName__c == 'Grievance')
                c.Subject = c.ContactName__c + ' - ' + c.Status;
            else if (c.RecordTypeName__c == 'EPO Incident') {
              
                  Map<Id, User> usersMap = new Map<Id, User>([Select Id,
                                                            Name,
                                                            JobCodeDescription__c 
                                                            From User
                                                            Where Id = :c.EPO_Complaint_Employee__c]);
         
                  Map<Id, NonEmployee__c> nonEmpMap = new Map<Id, NonEmployee__c>([Select Id,
                                                            Name
                                                            From NonEmployee__c
                                                            Where Id = :c.EPO_Complainant_Non_Employee__c]);
                
                c.Subject = '';
                if ( usersMap.get(c.EPO_Complaint_Employee__c) != null )
                    c.Subject = c.EPO__c + ' ' + usersMap.get(c.EPO_Complaint_Employee__c).Name;
                else if ( nonEmpMap.get(c.EPO_Complainant_Non_Employee__c) != null )
                    c.Subject = c.EPO__c + ' ' + nonEmpMap.get(c.EPO_Complainant_Non_Employee__c).Name; 
                else c.Subject = c.EPO__c + ' ' + 'No Complainant Info';
            }
        }    
    }
    
}