public class ComplianceCaseController  {
   
    private final Case c;

    public User CurrentUser {get{
        if(CurrentUser == null) 
            CurrentUser = queryCurrentUser();
            
        return CurrentUser;
    }set;}
    
    public void updateContact() {
        if(c.Contact__c == null) {
            return;
        }
    
        User u = [SELECT Id, Email, Phone
        FROM   User
        WHERE   Id =: c.Contact__c];
        
        if(u != null) {
            c.Contact_Information__c = u.Email;
            
            if(u.Phone != null)
                 c.Contact_Information__c += ', ' + u.Phone;
        }
    }
    
    public ComplianceCaseController(ApexPages.StandardController stdController) {
        this.c = (Case)stdController.getRecord();
        this.c.RecordTypeId = '0121Q000000oFtlQAE';
        
        if(c.id == null && CurrentUser != null) {
            c.Case_Owner__c = CurrentUser.Id;
        }
    }
    
    public void incrementAndAddCounter() {
        Counter__c counter;
        Counter__c[] counters = [SELECT   Id, Count__c
            FROM   Counter__c
            WHERE   Name = 'ComplianceCaseNumber'];
          
        if (counters.size() > 0) 
        {
            counter = counters[0];
          
            Integer count = Integer.ValueOf(counter.Count__c) + 1;
            String countStr = count + '';
            
            if(count <= 9999)
                countStr = '00' + countStr;
            else if(count <= 99999)
                countStr = '0' + countStr;
            else if(count <= 999999)
                countStr = countStr;
                
            c.Compliance_Case_Number__c = countStr;
            
            counter.Count__c = count + '';
            update counter;
        }
    }
    
    public PageReference save() {
        c.OwnerId = c.Case_Owner__c;
        
        try {
            if(c.id == null) {
                if(CurrentUser != null) {
                    c.Initiator__c = CurrentUser.Name;
                }
                
                insert c;
                incrementAndAddCounter();
                update c;
            } else {
                update c;
            }
            
            if(c.id != null) {
                PageReference casePage = new PageReference('/lightning/r/Case/' + c.id + '/view');
                //PageReference casePage = new ApexPages.StandardController(c).view();
                casePage.setRedirect(true);
                return casePage;
            }
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
            
        
        return null;
    }
    
    private User queryCurrentUser() {
        return [
            SELECT   Id, Email, Name, Profile.Name, UserRole.DeveloperName, Union_Representative__c, Is_Union__c 
            FROM   User 
            WHERE   Id =: UserInfo.getUserId()
        ];
    }
}