@isTest
public class TR_Utilities_TEST {
    public static testmethod void simpleTest() {
        
        TR_Utilities.IODateCalculations tri = new TR_Utilities.IODateCalculations();
        List<TR_Utilities.IODateCalculations> triList = new List<TR_Utilities.IODateCalculations>();
        tri.inputDate = System.today();
        tri.noOfDays = 20;
        triList.add(tri);
        test.startTest();
        TR_Utilities.addBusinessDays(triList);
        test.stopTest();
        for (TR_Utilities.IODateCalculations a : triList) {
        System.debug('Input Date: ' + a.inputDate);
            System.debug('No Days: ' + a.noOfDays);
            System.debug('Output Date: ' + a.outputDate);
            
        }
        
        
    }

}