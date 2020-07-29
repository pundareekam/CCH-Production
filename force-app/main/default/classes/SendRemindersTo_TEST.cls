@isTest
private class SendRemindersTo_TEST {
    static testMethod void simpleTest() {
     new SendRemindersTo();
     
        Id templateId;  
        try {templateId = [select id, name from EmailTemplate where developername = : 'Dual_Employment_Survey_Reminder'].id;}
        catch (Exception e) {}
     SendRemindersTo.sendTemplatedEmail(new String[] {'apatel@carminaticonsulting.com'}, new String[0], 'Dual_Employment_Survey_Reminder', '00536000003AchsAAC', null, null,false, null, templateId);   
    }
}