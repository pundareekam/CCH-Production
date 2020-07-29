public class DualEmploymentApprovalProcessController
{
    public DualEmploymentSurvey__c survey;
    public User owner;
    
    public User CurrentUser {get{
        if(CurrentUser == null) 
            CurrentUser = queryCurrentUser();
            
        return CurrentUser;
    }set;}
    
    public DualEmploymentApprovalProcessController(ApexPages.StandardController stdController) {
        survey = (DualEmploymentSurvey__c) stdController.getRecord();
        
        survey = [SELECT Id, 
        Has_Agreed_To_Comply_With_Policies__c, 
        Current_Step__c, 
        Is_A_Dual_Employee__c,
        On_Call_Or_Rotate_Shifts__c, 
        Outside_Employer__c, 
        Outside_Employer_Job_Title__c,
        Outside_Employer_Address__c, 
        Outside_Employer_City__c, 
        Outside_Employer_State__c, 
        Outside_Employer_Zip_Code__c, 
        Outside_Employer_Brief_Job_Description__c, 
        Outside_Employer_Job_Status__c,
        Outside_Employer_Hire_Date__c,
        Owned_Or_Controled_An_Organization__c, 
        Organization_Name__c, 
        Owner_Was_You_Or_Family__c, 
        Position_Within_Organization__c, 
        Involved_In_Sponsored_Research__c,
        Research_Sponsor_Name__c, 
        Research_Role__c, 
        Research_Project_Title__c, 
        Institutional_Review_Board_Info__c, 
        Under_Current_Research_Conflict_Mgt_Plan__c, 
        Conflict_Management_Plan_Assigned_By__c,
        Following_Conflict_Mgt_Plans__c, 
        Changes_Required_To_Conflict_Plan__c, 
        Notified_Assigning_Organization__c, 
        Has_Other_Conflicts__c, 
        Other_Conflicts__c, 
        Attestation_Time_Stamp__c, 
        Survey_Status__c,
        Survey_Final_Approval_Time_Stamp__c,
        Participated_In_The_Procurement_Process__c,
        Received_Gifts__c,
        Received_Gifts_From__c,
        Description_of_Gifts__c,
        Participated_In_Academic_Activities__c,
        Academic_Organizations__c,
        Received_Compensation_From_Activities__c,
        Served_In_A_Position_Of_Responsibility__c,
        Name_Of_Responsibility_Organization__c,
        Responsibility_Relationship__c,
        Responsibility_Position__c,
        Agrees_With_Attestation__c,
        Has_Second_Outside_Employer__c,
        Second_Outside_Employer__c,
        Second_Outside_Employer_Job_Title__c,
        Second_Outside_Employer_Address__c,
        Second_Outside_Employer_City__c,
        Second_Outside_Employer_State__c,
        Second_Outside_Employer_Zip_Code__c,
        Second_Outside_Employer_Job_Status__c,
        Second_Outside_Employer_Hire_Date__c,
        Second_Outside_Employer_Brief_Job__c,
        OutsideEmployer1MonStartTime__c,
        OutsideEmployer1MonEndTime__c,
        OutsideEmployer1TueStartTime__c,
        OutsideEmployer1TueEndTime__c,
        OutsideEmployer1WedStartTime__c,
        OutsideEmployer1WedEndTime__c,
        OutsideEmployer1ThurStartTime__c,
        OutsideEmployer1ThurEndTime__c,
        OutsideEmployer1FriStartTime__c,
        OutsideEmployer1FriEndTime__c,
        OutsideEmployer1SatStartTime__c,
        OutsideEmployer1SatEndTime__c,
        OutsideEmployer1SunStartTime__c,
        OutsideEmployer1SunEndTime__c,
        OutsideEmployer2MonStartTime__c,
        OutsideEmployer2MonEndTime__c,
        OutsideEmployer2TueStartTime__c,
        OutsideEmployer2TueEndTime__c,
        OutsideEmployer2WedStartTime__c,
        OutsideEmployer2WedEndTime__c,
        OutsideEmployer2ThurStartTime__c,
        OutsideEmployer2ThurEndTime__c,
        OutsideEmployer2FriStartTime__c,
        OutsideEmployer2FriEndTime__c,
        OutsideEmployer2SatStartTime__c,
        OutsideEmployer2SatEndTime__c,
        OutsideEmployer2SunStartTime__c,
        OutsideEmployer2SunEndTime__c,
        Third_Outside_Employer__c,
        Third_Outside_Employer_Job_Title__c,
        Third_Outside_Employer_Address__c,
        Third_Outside_Employer_City__c,
        Third_Outside_Employer_State__c,
        Third_Outside_Employer_Zip_Code__c,
        Third_Outside_Employer_Job_Status__c,
        Third_Outside_Employer_Hire_Date__c,
        Third_Outside_Employer_Brief_Job__c,
        OutsideEmployer3MonStartTime__c,
        OutsideEmployer3MonEndTime__c,
        OutsideEmployer3TueStartTime__c,
        OutsideEmployer3TueEndTime__c,
        OutsideEmployer3WedStartTime__c,
        OutsideEmployer3WedEndTime__c,
        OutsideEmployer3ThurStartTime__c,
        OutsideEmployer3ThurEndTime__c,
        OutsideEmployer3FriStartTime__c,
        OutsideEmployer3FriEndTime__c,
        OutsideEmployer3SatStartTime__c,
        OutsideEmployer3SatEndTime__c,
        OutsideEmployer3SunStartTime__c,
        OutsideEmployer3SunEndTime__c,
        Fourth_Outside_Employer__c,
        Fourth_Outside_Employer_Job_Title__c,
        Fourth_Outside_Employer_Address__c,
        Fourth_Outside_Employer_City__c,
        Fourth_Outside_Employer_State__c,
        Fourth_Outside_Employer_Zip_Code__c,
        Fourth_Outside_Employer_Job_Status__c,
        Fourth_Outside_Employer_Hire_Date__c,
        Fourth_Outside_Employer_Brief_Job__c,
        Has_Third_Outside_Employer__c,
        Has_Fourth_Outside_Employer__c,
        OutsideEmployer1TotalHours__c,
        OutsideEmployer2TotalHours__c,
        OutsideEmployer3TotalHours__c,
        OutsideEmployer4TotalHours__c,
        OutsideEmployer4MonStartTime__c,
        OutsideEmployer4MonEndTime__c,
        OutsideEmployer4TueStartTime__c,
        OutsideEmployer4TueEndTime__c,
        OutsideEmployer4WedStartTime__c,
        OutsideEmployer4WedEndTime__c,
        OutsideEmployer4ThurStartTime__c,
        OutsideEmployer4ThurEndTime__c,
        OutsideEmployer4FriStartTime__c,
        OutsideEmployer4FriEndTime__c,
        OutsideEmployer4SatStartTime__c,
        OutsideEmployer4SatEndTime__c,
        OutsideEmployer4SunStartTime__c,
        OutsideEmployer4SunEndTime__c, 
        Survey_Assigned_To__c, 
        ApproveDeny__c, 
        Denial_Comment__c,
        OwnerId,
        CreatedDate,
        Is_Owners_Supervisor__c,
        Survey_Status_Description__c,
        SupervisorsSupervisorId__c,
        Is_Owner_s_Supervisor_s_Supervisor__c,
        Assigned_To_User__c


            FROM   DualEmploymentSurvey__c
            WHERE   Id=: survey.Id limit 1];

        Owner = [SELECT Id, Name, Department, BusinessUnitDescription__c
            FROM   User
            WHERE   Id=: survey.OwnerId limit 1];
    }
    
    public PageReference save() {
        string johnSId1 = '005360000047UakAAE';
        string johnSId2 = '005360000047Uak';
        
        try {
            if(survey.ApproveDeny__c == 'Approve') {
               if(survey.Survey_Status__c == 2 && (Survey.SupervisorsSupervisorId__c != johnSId1 || Survey.SupervisorsSupervisorId__c != johnSId2)) {
                   survey.Survey_Status__c = 3;
                   survey.Denial_Comment__c = '';
                   survey.Survey_Assigned_To__c = CurrentUser.Supervisor__c;
               } else if(survey.Survey_Status__c == 3 || Survey.SupervisorsSupervisorId__c == johnSId1 || Survey.SupervisorsSupervisorId__c == johnSId2) {
                   survey.Survey_Status__c = 5;
                   survey.Denial_Comment__c = '';
                   survey.Survey_Assigned_To__c = null;
               }
            } else {
               survey.Survey_Status__c = 6;
            }
            
            update survey;
            
            PageReference required = new PageReference('/lightning/o/DualEmploymentSurvey__c/list');
            required.setRedirect(true);
            return required;
            
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        return null;
    }
    
    public DualEmploymentSurvey__c getSurvey() {
        return survey;
    }

    public User getOwner() {
        return Owner;
    }
    
    public boolean getIsAssigned() {
        return (survey.Assigned_To_User__c == 1);
    }

    public boolean getCanView() {
        return (CurrentUser.Profile.Name == 'Cook County Health Compliance Administrator' || CurrentUser.Profile.Name == 'Cook County Health HR Administrator' || CurrentUser.Profile.Name == 'Cook County Health Compliance Team' || survey.Is_Owners_Supervisor__c == 1 || survey.Is_Owner_s_Supervisor_s_Supervisor__c    == 1);
    }
    
    private User queryCurrentUser() {
        return [
            SELECT   Id, Email, Name, Profile.Name, UserRole.DeveloperName, Supervisor__c
            FROM   User 
            WHERE   Id =: UserInfo.getUserId()
        ];
    }

}