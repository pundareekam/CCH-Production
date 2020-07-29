// Get a map of all fields available to you on the MyObject__c table/object
// keyed by the API name of each field
Map<String,Schema.SObjectField> caseObjectFields 
   = Contact.SObjectType.getDescribe().fields.getMap();

// Get a Set of the field names
Set<String> caseObjectFieldAPINames = caseObjectFields.keyset();

// Print out the names to the debug log
 String allFields = 'ALL ACCESSIBLE FIELDS on Case:\n\n';
for (String s : caseObjectFieldAPINames) {
    allFields += s + '\n';
}
System.debug(allFields);