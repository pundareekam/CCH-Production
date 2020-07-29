@isTest
private class DualEmploymentController_TEST {
    static testMethod void simpleTest() {
        User u = [SELECT Id FROM User WHERE Alias= 'admin'];
        DualEmploymentSurvey__c survey = new DualEmploymentSurvey__c();
        survey.Current_Step__c = 1;
        
        System.runAs(u){
            DualEmploymentController ccc = new DualEmploymentController();
            ccc.survey = survey;
            
            ccc.save();
            ccc.save();
            if(ccc.CurrentUser != null) System.debug('good');
            if(ccc.getSurvey() != null) System.debug('good');
            if(ccc.survey != null) System.debug('good');
            
            PageReference ref = new PageReference('/apex/DualEmploymentSurvey');
            test.setCurrentPage(ref); 
            ccc.next();
            ccc.previous();
            ccc.previous();
            survey.Current_Step__c = 10;
            ccc.next();
            survey.Current_Step__c = 12;
            ccc.next();
            ccc.calcTotal();
            ccc.calcJob2Hours();
            ccc.calcJob3Hours();
            ccc.calcJob4Hours();
            ccc.startOver();
            survey.OutsideEmployer1MonEndTime__c = '00:00';
            survey.OutsideEmployer1MonStartTime__c = '00:00';
            ccc.calcTotal();
            survey.OutsideEmployer1TueEndTime__c = '00:00';
            survey.OutsideEmployer1TueStartTime__c = '00:00';
            ccc.calcTotal();
            ccc.calcHours(null, null);
            ccc.calcHours('00:00', '00:00');
        }
    }
}