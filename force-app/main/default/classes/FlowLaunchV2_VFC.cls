public with sharing class FlowLaunchV2_VFC {
    public class Flow{
        public string Title {get;set;}
        public string Url {get;set;}
        public string Image {get;set;}
        public string HelpText {get;set;}
        
        public Flow(Map<String, Object> initMap) {
            Title = (String)initMap.get('Title');
            Url = (String)initMap.get('Url');
            Image = (String)initMap.get('Image');
            HelpText = (String)initMap.get('HelpText');
        }
    }
    
    public List<Flow> flowList { get;set; }

    public User CurrentUser {get{
        if(CurrentUser == null) 
            CurrentUser = queryCurrentUser();
            
        return CurrentUser;
    }set;}
    
    public Contact CurrentUserContact {get{
        if(CurrentUserContact == null) 
            CurrentUserContact = queryCurrentUserContact();
            
        return CurrentUserContact;
    }set;}
    
    public String ScheduleLinkParams {get{
        if(CurrentUserContact != null && CurrentUserContact.Id != null)
            return 'sosfContactId=' + CurrentUserContact.Id;
        else
            return 'sosfContactId=' + CurrentUser.Email;
    }}
    
    public List<Flow> flowsList {get{
        if(flowsList == null) {
            flowsList = new List<Flow>();
           
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Employee Relations' , 'Url' => '/apex/EEO_Flow_VFP', 'Image' => '/resource/1537447908000/HR_Self_Help_Icon_Meet_HR_Rep' }));            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Request time off, Review Time Card Link to CC time' , 'Url' => 'https://sts.cookcountyil.gov/adfs/ls/idpinitiatedsignon.aspx?RelayState=RPID%3Dhttps%253A%252F%252Fcookcounty.workforcehosting.com%26RelayState%3D', 'Image' => '/resource/1537448777000/HR_Self_Help_Icon_Time_Request?v=2' }));
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'ADA / FMLA Workflow' , 'Url' => '/apex/ADA_FMLA_Workflow_VFP', 'Image' => '/resource/1539713260000/HR_Self_Help_Icon_FMLA' }));
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Meeting Request with Leave Team' , 'Url' => 'https://meetme.so/CCHHSMeetingRequestWithLeaveTeam?' + ScheduleLinkParams, 'Image' => '/resource/1537447939000/HR_Self_Help_Icon_Meeting_Request?' }));            
            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Manage Your Benefits & Update Personal Details' , 'Url' => 'https://ssoprod.cookcountyil.gov/oam/server/obrareq.cgi?encquery%3DD7dX0pwdBYZ%2BAQV%2B8%2FyLqdW3KdmKf%2F6dtf63be9gIvHyzcqcDT6x5G2JOl0DJ9HMQw5J8TAgwwaZX%2FQBAu1Hgl2xi5L3FAPssvv%2FPrG%2BfJaXxjy%2F1GWKLk8O7XicWLq1u3wUBrZTJ1H6iM7PV85ykmiGqUT%2Fk3kqoD8R3WoLJF5hE0ICzJfoDRyG8NGdp3sja0anjcN%2F9rm5Ioy%2F3%2FvUlWMDnfjskoxe6TmOJoh4JLlteE9eVGI9o4n2aJKSWJJmXVPnyfKIGk%2BNoo96sBrKKLAj3WQXBXr3eskwGXOKg2gkSDK0FWysAc5wZ28bmbP%2BeQ70ORx%2FQ9AT2WBYAzSdZptk%2BhHAJwpuYMqDZCinI9g%3D%20agentid%3DZ9XP1AA_ccgprod.ccounty.com_443%20ver%3D1%20crmethod%3D2&ECID-Context=1.000002vyDC46yGq5kNd9iZ00_02e002Sjm%3BkXjE', 'Image' => '/resource/1537447963000/HR_Self_Help_Icon_Oracle' }));            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Pay Rate Accrual Errors' , 'Url' => '/apex/Pay_Accrual_Error_Flow_VFP', 'Image' => '/resource/1537447997000/HR_Self_Help_Icon_Pay_Rate' }));
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Employee ID Badge Appointment', 'Url' => 'https://meetme.so/CCHHSBadgeAppointment?' + ScheduleLinkParams, 'Image' => '/resource/1537447799000/HR_Self_Help_Icon_ID_Badge_Appt' }));
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Tuition Reimbursement' , 'Url' => '/apex/Tuition_Reimbursement_Flow_VFP', 'Image' => '/resource/1537448796000/HR_Self_Help_Icon_Tuition_App' }));
            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Separation Exit' , 'Url' => '/apex/Exit_Packet_Flow_VFP', 'Image' => '/resource/1537448730000/HR_Self_Help_Icon_Separation_Exit' }));            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Employee Verification' , 'Url' => '/apex/Confidential_Employment_Ver_Flow_VFP', 'Image' => '/resource/1537447716000/HR_Self_Help_Icon_Employee_Verification' }));            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Performance Management' , 'Url' => '/apex/CCHInprogress', 'Image' => '/resource/1541537230000/HR_Self_Help_Icon_Performance_Mgt' }));            

   //       flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Performance Management' , 'Url' => 'https://egtj.fa.us2.oraclecloud.com', 'Image' => '/resource/1541537230000/HR_Self_Help_Icon_Performance_Mgt' }));            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Organizational Development & Learning' , 'Url' => 'http://cchintranet.cchhs.local/Intranet/main.aspx?tid=581&mtid=634', 'Image' => '/resource/1539713299000/HR_Self_Help_Icon_LMS' }));            
            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Schedule a Meeting with an HR Representative' , 'Url' => 'https://meetme.so/CCHHSMeetingsWithHR?' + ScheduleLinkParams, 'Image' => '/resource/1537448709000/HR_Self_Help_Icon_Schedule_with_HR_Rep' }));
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Ask HR!' , 'Url' => '/apex/Ask_HR_A_Question_VFP', 'Image' => '/resource/1537447652000/HR_Self_Help_Icon_Ask_HR' }));            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Current Job Opportunities' , 'Url' => 'https://cookcountyhealth.org/about/human-resources/', 'Image' => '/resource/1537447826000/HR_Self_Help_Icon_Jobs' }));            
            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Employee Assistance Program' , 'Url' => '/lightning/n/Employee_Assistance_Program', 'Image' => '/resource/1537448709000/HR_Self_Help_Icon_EAP' }));
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Space Filler' , 'Url' => '', 'Image' => '/resource/1539712891000/HR_Self_Help_Icon_Space_Filler' }));            
            flowsList .add(new Flow(new Map<String, Object>{ 'Title' => 'Legal Aid & Other Benefits Information' , 'Url' => '/apex/Legal_Aid', 'Image' => '/resource/1539713095000/HR_Self_Help_Icon_Benefits' }));            
            
        }
           
        return flowsList;
    }set;}
    
    private User queryCurrentUser() {
        return [
            SELECT   Id, Email, Profile.Name, UserRole.DeveloperName, Union_Representative__c, Is_Union__c 
            FROM   User 
            WHERE   Id =: UserInfo.getUserId()
        ];
    }
    
    private Contact queryCurrentUserContact() {
        Contact[] c = [
            SELECT   Id
            FROM   Contact 
            WHERE   ownerid =: UserInfo.getUserId()
        ];
    
        if(c.size() > 0)
            return c[0];
        else
            return null;
    }
}