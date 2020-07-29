public class TuitionReimbursementController {
    
    private final Case c;
    public String editMode { get; set;}
    
    public User CurrentUser {get{
        if(CurrentUser == null) 
            CurrentUser = queryCurrentUser();
        return CurrentUser;
    }set;}

   
    public TuitionReimbursementController(ApexPages.StandardController stdController) {
        this.c = (Case)stdController.getRecord();
        if ( currentUser.Profile.Name == 'Cook County Health Employee' )
           editMode = 'detail';
        else
           editMode = 'inlineEdit';
        if (c.Status == 'HR Review Pending')
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'***HR Approval Alert***</br>' +
                                                     '•	Grade transcripts</br>' +
                                                     '•	Paid Receipt Documentation of payment such as credit card receipt or cancelled check</br>'+
                                                     '•	Itemized Statement/Bill  from the school'));
        
    }
    
    public PageReference save() {
     
        try {
            if(c.id == null) {               
                insert c;
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