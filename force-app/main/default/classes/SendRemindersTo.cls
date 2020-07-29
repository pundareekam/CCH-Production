global class SendRemindersTo implements Schedulable
{
    global SendRemindersTo()
    {
        DualEmploymentSurvey__c [] s = 
        [
            SELECT Owner.Name, Owner.Email, Owner.Id
            FROM DualEmploymentSurvey__c 
            WHERE  (Survey_Status_Description__c = 'Not Started' OR Survey_Status_Description__c = 'In Progress') 
        ];
        

        List <Messaging.SingleEmailMessage> emails  =  new List<Messaging.SingleEmailMessage>();

        Id templateId;  
        try {templateId = [select id, name from EmailTemplate where developername = : 'Dual_Employment_Survey_Reminder'].id;}
        catch (Exception e) {}
        

        for(DualEmploymentSurvey__c x : s)
        {
            emails.add(sendTemplatedEmail(new String[] {x.Owner.Email}, new String[0], 'Dual_Employment_Survey_Reminder', x.Owner.Id, null, null,false, null, templateId));

        }

        /*for(Integer x=0; x<=2100; x++){
        emails.add(sendTemplatedEmail(new String[] {'apatel@carminaticonsulting.com'}, new String[0], 'Dual_Employment_Survey_Reminder', '00536000003AchsAAC', null, null,false, null, templateId));
        }*/
        
        Messaging.sendEmail(emails);
    }

    global void execute(SchedulableContext SC)
    {
        SendRemindersTo s = new SendRemindersTo();
    }

    //  -------------------------------------------------------------------------
    //  HELPER method: sendTemplatedEmail
    //  -------------------------------------------------------------------------
    public static Messaging.SingleEmailMessage sendTemplatedEmail(String[] toRecipients, String[] ccRecipients, String templateApiName, ID targetObjId, Id whatId, ID orgWideEmailId, Boolean saveAsActivity, Attachment[] attachList, Id templateId) 
    {
    //  templateId   must be ID of an Email template
    //  targetObjId must be a Contact, User, Lead Id -- also used in merge fields of template recipient.xxxx
    //  whatId    must be an SObject that is used in the merge fields of the template relatedTo.xxxx
    //  fromId    if non null, use current user, otherwise, use this ID (most likely an org wide no reply id)
    //  bcc      not permitted when using templates
    
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();



    
            
        email.setToAddresses(toRecipients);
        email.setCcAddresses(ccRecipients);
        email.setTargetObjectId(targetObjId);
        email.setWhatId(whatId);
        email.setorgWideEmailAddressId(orgWideEmailId);
        email.setTemplateId(templateId);
        email.setSaveAsActivity(saveAsActivity);      // save email as activity on the targetObjId (i.e. Contact). Note activity can't be saved on Users
        
        return email;
    
    }  
}