@isTest
private class DualEmploymentApprovalProcess_TEST {
    static testMethod void simpleTest() {
        User u = [SELECT Id FROM User WHERE Alias= 'admin'];
        DualEmploymentSurvey__c survey = new DualEmploymentSurvey__c();
        insert survey;
        
        System.runAs(u){
            ApexPages.StandardController sc = new ApexPages.StandardController(survey);
            DualEmploymentApprovalProcessController ccc = new DualEmploymentApprovalProcessController(sc);
            ccc.survey = survey;
            
            if(ccc.CurrentUser != null) System.debug('good');
            if(ccc.getSurvey() != null) System.debug('good');
            if(ccc.survey != null) System.debug('good');
            if(ccc.getIsAssigned() == false) System.debug('good');
            if(ccc.getOwner() != null) System.debug('good');
            if(ccc.getCanView() != null) System.debug('good');
            
            PageReference ref = new PageReference('/apex/DualEmploymentSurvey');
            test.setCurrentPage(ref); 
            ccc.save();
        }
    }
}