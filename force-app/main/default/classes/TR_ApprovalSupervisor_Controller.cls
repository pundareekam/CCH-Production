public with sharing class TR_ApprovalSupervisor_Controller {
    
    ApexPages.StandardController stdctrl;
    public boolean showCaseDetails {get; set;}
    public Case currentCase;
    public User owner;
    public User CurrentUser {get{
        if(CurrentUser == null) 
            CurrentUser = queryCurrentUser();
        
        return CurrentUser;
    }set;}
    
    public TR_ApprovalSupervisor_Controller(ApexPages.StandardController stdController) {
        stdctrl = stdController;
        currentCase = (Case) stdController.getRecord();
        if (currentCase.Id != null)
        { 
            currentCase = [Select Id, Supervisor__c, Tuition_Reimbursement_Case_Status__c From Case Where Id = :currentCase.Id];
            if ( currentCase.Supervisor__c == CurrentUser.Id )
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,
                                                           '* When reviewing and approving  Tuition Reimbursement Requests there are three elements necessary for compliance.' + '<br/>' +
                                                           '1.Nursing or Nursing related degree documentation' +'<br/>' +
                                                           '2.Official course curriculum for the Semester ' +'<br/>' +
                                                           '3.Course schedule with start and end dates ' +'<br/>' +
                                                           'Please refer below link for Supporting Tools ' 
                                                          ));
                showCaseDetails = true;
            }
            else
            {
                showCaseDetails = false;
                if (currentCase.Tuition_Reimbursement_Case_Status__c == 'Approved' || 
                    currentCase.Tuition_Reimbursement_Case_Status__c == 'Rejected' ||
                    currentCase.Tuition_Reimbursement_Case_Status__c == 'Approved - Grades Submitted')
                    
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'This record is already Approve or Rejected by Supervisor'));
                else
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'This page Can only viewed by supervisor'));          
            }
        }
        else
        {
            showCaseDetails = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No Records Found. Please Contact Your System Administrator'));
        }
    }
    
    public PageReference approve(){
        currentCase.Tuition_Reimbursement_Case_Status__c = 'Approved';
        currentCase.TR_Supervisor_Approval_Date_Time__c = Datetime.now();
        try {
            update currentCase;
            stdctrl.save(); 
        } catch(DmlException e) { 
            System.debug('An unexpected error has occurred: ' + e.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'DML Error Occured'));
        }
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Tuition Reimbursement Record Approved.'));  
        return null;       
    }
    
    public PageReference reject(){
        currentCase.Tuition_Reimbursement_Case_Status__c = 'Rejected';
        currentCase.TR_Supervisor_Approval_Date_Time__c = Datetime.now();
        try {
            update currentCase;
            stdctrl.save();
        } catch(DmlException e) { 
            System.debug('An unexpected error has occurred: ' + e.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'DML Error Occured'));
        }
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Tuition Reimbursement Record Rejected.'));
        
        return null;
    }
    
    private User queryCurrentUser() {
        return [
            SELECT   Id, Email, Name, Profile.Name, UserRole.DeveloperName, Supervisor__c
            FROM   User 
            WHERE   Id =: UserInfo.getUserId()
        ];
    }
}