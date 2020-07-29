/**
 * @File Name          : TR_Utilities.cls
 * @Description        : 
 * @Author             : Pundareekam Kudikala
 * @Group              : 
 * @Last Modified By   : Pundareekam Kudikala
 * @Last Modified On   : 12/3/2019, 3:20:34 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/15/2019   Pundareekam Kudikala         Initial Version
**/
global class TR_Utilities {
    
    @InvocableMethod(label='Add Business Days to input date excluding holidays and weekends')
    global static List<IODateCalculations> addBusinessDays(List<IODateCalculations> io){
        List<IODateCalculations> output = new List<IODateCalculations>();
        for ( IODateCalculations a : io ) {
            a.outputDate = addBussinessDays(a.inputDate, a.noOfDays);
            output.add(a);
            System.debug('output date '+ a);
            System.debug('testng');
        }
        
        return output;        
    } 	 
//Method for add Businessdays
    public static Date addBussinessDays(Date startDate, Integer iDays)
    {
        Integer businessDaysAdded = 0;
        Date currentDate = startDate;
        while (businessDaysAdded < iDays) {
            currentDate = currentDate.addDays(1);
            Datetime d = datetime.newInstance(currentDate.year(),currentDate.month(),currentDate.day());
            
            if (d.format('E') != 'Sat' && d.format('E') != 'Sun' && checkifItisWorkingDay(currentDate)) {
                // it's a business day, so add 1 to the counter that works towards the amount of days to add
                businessDaysAdded = businessDaysAdded + 1;
            } 
        }       
        return currentDate;
    }
    
    public static List<Holiday> holidays {
        get {
            if(holidays == null)
                holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
            return holidays;
        }
        private set;
    }

    public static boolean checkifItisWorkingDay(Date currentDate){
        Date weekStart  = currentDate.toStartofWeek();
        for(Holiday hDay:holidays){
            if(currentDate.daysBetween(hDay.ActivityDate) == 0){
                return false;
            }
        }
        if(weekStart.daysBetween(currentDate) == 0 || weekStart.daysBetween(currentDate) == 6){
            return false;
        } else 
            return true;
    } 
    
    global class IODateCalculations {
        
        @InvocableVariable(required=true)
        global Date inputDate;
        
        @InvocableVariable(required=true)
        global integer noOfDays;
        
        @InvocableVariable
        global Date outputDate;
        
    }
}