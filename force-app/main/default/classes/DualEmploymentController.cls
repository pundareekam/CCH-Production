public class DualEmploymentController {

    public DualEmploymentSurvey__c survey;
    
    public User CurrentUser {get{
        if(CurrentUser == null) 
            CurrentUser = queryCurrentUser();
            
        return CurrentUser;
    }set;}
    
    public Decimal TotalTotal { get { calcTotal();calcJob2Hours();calcJob3Hours();calcJob4Hours(); return survey.OutsideEmployer1TotalHours__c + survey.OutsideEmployer2TotalHours__c + survey.OutsideEmployer3TotalHours__c + survey.OutsideEmployer4TotalHours__c; } }
    
    public DualEmploymentController () {
        DualEmploymentSurvey__c[] s = 
        [SELECT Id, 
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
        CreatedDate
   
        FROM   DualEmploymentSurvey__c
        WHERE   OwnerId =: CurrentUser.Id];
        
        if (s.size() > 0)
        {
            this.survey = s[0];
            
            string isEntry = Apexpages.currentpage().getparameters().get('entry');
            if(isEntry == 'true') {
                PageReference casePage = new PageReference('/apex/DualEmploymentSurvey');
                survey.Current_Step__c = 1;
            }        
        }
        else
        {
            survey = new DualEmploymentSurvey__c();
            survey.Current_Step__c = 1;
            survey.Survey_Status__c = 0;
        }
    }
    
    public PageReference save(){
        try {
            if(survey.id == null) {
                survey.Survey_Status__c = 1;
                insert survey;
            } else {
                update survey;
            }

            if(survey.id != null) {
                PageReference casePage = new PageReference('/apex/DualEmploymentSurvey');
                casePage.setRedirect(true);
                return casePage;
            }
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        return null;
    }

    public DualEmploymentSurvey__c getSurvey(){
        return survey;
    }

    public Decimal calcHours(string endTime, string startTime)
    {
        if(endTime != null && startTime != null)
        {
            Decimal dStart = Decimal.valueof(startTime.replaceAll( ':00', ''));
            Decimal dEnd = Decimal.valueof(endTime.replaceAll( ':00', ''));

            if(dEnd < dStart)
                dEnd = dEnd + 24;

            return dEnd - dStart;
        }

        return 0;
    }
    
    public PageReference calcTotal(){
        Decimal mondayTotal;
        Decimal tuesdayTotal;
        Decimal wednesdayTotal;
        Decimal thursdayTotal;
        Decimal fridayTotal;
        Decimal saturdayTotal;
        Decimal sundayTotal;
        survey.OutsideEmployer1TotalHours__c = 0;
        
        mondayTotal = calcHours(survey.OutsideEmployer1MonEndTime__c, survey.OutsideEmployer1MonStartTime__c);
        tuesdayTotal = calcHours(survey.OutsideEmployer1TueEndTime__c, survey.OutsideEmployer1TueStartTime__c);
        wednesdayTotal = calcHours(survey.OutsideEmployer1WedEndTime__c, survey.OutsideEmployer1WedStartTime__c);
        thursdayTotal = calcHours(survey.OutsideEmployer1ThurEndTime__c, survey.OutsideEmployer1ThurStartTime__c);
        fridayTotal = calcHours(survey.OutsideEmployer1FriEndTime__c, survey.OutsideEmployer1FriStartTime__c);
        saturdayTotal = calcHours(survey.OutsideEmployer1SatEndTime__c, survey.OutsideEmployer1SatStartTime__c);
        sundayTotal = calcHours(survey.OutsideEmployer1SunEndTime__c, survey.OutsideEmployer1SunStartTime__c);
        
        if((mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal) > 0)
        {
            survey.OutsideEmployer1TotalHours__c = mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal;
        }
        else
        {
            survey.OutsideEmployer1TotalHours__c = 0;
        }

        return null;
    }

    public PageReference calcJob2Hours(){
        Decimal mondayTotal,tuesdayTotal, wednesdayTotal, thursdayTotal, fridayTotal, saturdayTotal, sundayTotal;
        survey.OutsideEmployer2TotalHours__c = 0;
        mondayTotal = calcHours(survey.OutsideEmployer2MonEndTime__c, survey.OutsideEmployer2MonStartTime__c);
        tuesdayTotal = calcHours(survey.OutsideEmployer2TueEndTime__c, survey.OutsideEmployer2TueStartTime__c);
        wednesdayTotal = calcHours(survey.OutsideEmployer2WedEndTime__c, survey.OutsideEmployer2WedStartTime__c);
        thursdayTotal = calcHours(survey.OutsideEmployer2ThurEndTime__c, survey.OutsideEmployer2ThurStartTime__c);
        fridayTotal = calcHours(survey.OutsideEmployer2FriEndTime__c, survey.OutsideEmployer2FriStartTime__c);
        saturdayTotal = calcHours(survey.OutsideEmployer2SatEndTime__c, survey.OutsideEmployer2SatStartTime__c);
        sundayTotal = calcHours(survey.OutsideEmployer2SunEndTime__c, survey.OutsideEmployer2SunStartTime__c);

        if((mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal) > 0)
        {
            survey.OutsideEmployer2TotalHours__c = mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal;
        }
        else
        {
            survey.OutsideEmployer2TotalHours__c = 0;    
        }
        return null;       
    }

    public PageReference calcJob3Hours(){
        Decimal mondayTotal,tuesdayTotal, wednesdayTotal, thursdayTotal, fridayTotal, saturdayTotal, sundayTotal;
        survey.OutsideEmployer3TotalHours__c = 0;
        mondayTotal = calcHours(survey.OutsideEmployer3MonEndTime__c, survey.OutsideEmployer3MonStartTime__c);
        tuesdayTotal = calcHours(survey.OutsideEmployer3TueEndTime__c, survey.OutsideEmployer3TueStartTime__c);
        wednesdayTotal = calcHours(survey.OutsideEmployer3WedEndTime__c, survey.OutsideEmployer3WedStartTime__c);
        thursdayTotal = calcHours(survey.OutsideEmployer3ThurEndTime__c, survey.OutsideEmployer3ThurStartTime__c);
        fridayTotal = calcHours(survey.OutsideEmployer3FriEndTime__c, survey.OutsideEmployer3FriStartTime__c);
        saturdayTotal = calcHours(survey.OutsideEmployer3SatEndTime__c, survey.OutsideEmployer3SatStartTime__c);
        sundayTotal = calcHours(survey.OutsideEmployer3SunEndTime__c, survey.OutsideEmployer3SunStartTime__c);
        
        if((mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal) > 0)
        {
            survey.OutsideEmployer3TotalHours__c = mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal;
        }
        else
        {
            survey.OutsideEmployer3TotalHours__c = 0;    
        }
        return null;       
    }

    public PageReference calcJob4Hours(){
        Decimal mondayTotal,tuesdayTotal, wednesdayTotal, thursdayTotal, fridayTotal, saturdayTotal, sundayTotal;
        survey.OutsideEmployer4TotalHours__c = 0;
        mondayTotal = calcHours(survey.OutsideEmployer4MonEndTime__c, survey.OutsideEmployer4MonStartTime__c);
        tuesdayTotal = calcHours(survey.OutsideEmployer4TueEndTime__c, survey.OutsideEmployer4TueStartTime__c);
        wednesdayTotal = calcHours(survey.OutsideEmployer4WedEndTime__c, survey.OutsideEmployer4WedStartTime__c);
        thursdayTotal = calcHours(survey.OutsideEmployer4ThurEndTime__c, survey.OutsideEmployer4ThurStartTime__c);
        fridayTotal = calcHours(survey.OutsideEmployer4FriEndTime__c, survey.OutsideEmployer4FriStartTime__c);
        saturdayTotal = calcHours(survey.OutsideEmployer4SatEndTime__c, survey.OutsideEmployer4SatStartTime__c);
        sundayTotal = calcHours(survey.OutsideEmployer4SunEndTime__c, survey.OutsideEmployer4SunStartTime__c);
        
        if((mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal) > 0)
        {
            survey.OutsideEmployer4TotalHours__c = mondayTotal + tuesdayTotal + wednesdayTotal + thursdayTotal + fridayTotal + saturdayTotal + sundayTotal;
        }
        else
        {
            survey.OutsideEmployer4TotalHours__c = 0;    
        }
        return null;       
    }
    
    public PageReference previous(){
        if (survey.Current_Step__c > 1)
        {
            survey.Current_Step__c--;
        }
        else
        {
            survey.Current_Step__c = 1; 
        }
        return null;
    }

    public PageReference next(){
        if(survey.Has_Agreed_To_Comply_With_Policies__c == 'Disagree' || survey.Agrees_With_Attestation__c == 'Disagree')
        {
            survey.Survey_Status__c = 1;
            survey.Survey_Assigned_To__c = null;
        } 
        else if (survey.Current_Step__c == 12) 
        {
            // final page
            string johnSId = '005360000047UakAAE';

            if(survey.Is_A_Dual_Employee__c == 'No' && survey.Owned_Or_Controled_An_Organization__c == 'No' && 
                    survey.Involved_In_Sponsored_Research__c == 'No' && survey.Has_Other_Conflicts__c == 'No' && survey.Participated_In_The_Procurement_Process__c == 'No')
            {
                // auto approve
               survey.Survey_Status__c = 4; 
               survey.Survey_Assigned_To__c = null;
            }
            else
            {
                survey.Survey_Assigned_To__c = CurrentUser.Supervisor__c;
                survey.Survey_Status__c = 2;
            } 
            // else {
            //     // John S auto approval logic
            //     survey.Survey_Status__c = 4;
            //     survey.Denial_Comment__c = '';
            //     survey.Survey_Assigned_To__c = null;                
            // }

            survey.Current_Step__c = 13; 
        }
        else
        {
            if(survey.Current_Step__c >= 13)
            {
                survey.Current_Step__c = 13;
            }
            else
            {
                survey.Current_Step__c ++;
            }
        } 

        if(survey.id == null) {
            insert survey;
        } else {
            update survey;
        }

        return null;
    }

    public PageReference startOver()
    {
        survey.Current_Step__c = 3;
        return null;    
    }
    
    private User queryCurrentUser(){
        return [
            SELECT   Id, Email, Name, Profile.Name, UserRole.DeveloperName, Supervisor__c 
            FROM   User 
            WHERE   Id =: UserInfo.getUserId()
        ];
    }
}