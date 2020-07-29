/*
	1:1 field mappings based on process definitions
*/
public without sharing class MappingUtil {


	public class MappingUtilException extends Exception {}

	// allows for the user to override certain fields on the case
	// because they are not correct in E1
	public static Set<String> e1UpdateFields;
	public static Set<String> getE1UpdateFields() {
		if(e1UpdateFields == null) {
			e1UpdateFields = new Set<String>();
			for(Field_Mapping__mdt fm:[
				SELECT 	Processes__c, From_Object__c, From_Field__c, To_Object__c, To_Field__c, Optional_Change_From_E1__c
				FROM 	Field_Mapping__mdt
				WHERE	Optional_Change_From_E1__c = true
			]) {
				e1UpdateFields.add(fm.To_Field__c);
			}
		}
		return e1UpdateFields;
	}


	public static String normalizeProcessName(String procName) {
		return procName.trim().replaceAll('[\\s]+','').toLowerCase();
	}


	public static Map<String,MappingProcess> processes;
	public static MappingProcess getProcess(String processName) {
		if(processes == null) {
			String tempProcName;
			Integer cnt = 0;
			MappingProcess proc;
			processes = new Map<String,MappingProcess>();
			for(Field_Mapping__mdt fm:[
				SELECT Processes__c, From_Object__c, From_Field__c, To_Object__c, To_Field__c
				FROM Field_Mapping__mdt
			]) {
				if(String.isNotBlank(fm.Processes__c)) {
					for(String str:fm.Processes__c.split('\n')) {
						cnt++;
						System.debug(cnt + ' ' + str);
						if(String.isNotBlank(str)) {
							tempProcName = normalizeProcessName(str);
							if(processes.containsKey(tempProcName)) {
								processes.get(tempProcName).addMapping(fm);
							} else {
								System.debug('creating new process: ' + tempProcName);
								proc = new MappingProcess(tempProcName,fm);
								processes.put(tempProcName,proc);
							}
						}
					}
				}
			}
			tempProcName = null;
			cnt = null;
			proc = null;
		}
		String checkProcName = normalizeProcessName(processName);
		return processes.containsKey(checkProcName) ? processes.get(checkProcName) : null;
	}


	public static SObject doIt(String processName, SOBject fromObj, SOBject toObj) {
		MappingProcess proc = getProcess(processName);
		if(proc != null) {
			System.debug('processName: ' + processName);
			for(String fromField:new List<String>(proc.FieldMappings.keySet())) {
				// if the user wants the E1 fields update, then don't overwrite them
				IF(getE1UpdateFields().contains(proc.FieldMappings.get(fromField))) System.debug(proc.FieldMappings.get(fromField) + ': ('+(getE1UpdateFields().contains(proc.FieldMappings.get(fromField))) + ' && ' + (!(Boolean)toObj.get('ChangeContactInfoInE1__c'))+')');
				if((
						getE1UpdateFields().contains(proc.FieldMappings.get(fromField))
						&&
						!(Boolean)toObj.get('ChangeContactInfoInE1__c')
					)
					||
					!getE1UpdateFields().contains(proc.FieldMappings.get(fromField))
				) {
					if(fromField == 'Phone__c') System.debug('Got inside');
					toObj.put(proc.FieldMappings.get(fromField),fromObj.get(fromField));
				}

				if(fromField == 'Phone__c') {
					System.debug((String)fromObj.get(fromField));
				}
			}
		} else {
			System.debug(processName + ' is not supported by this system');
		}
		proc = null;
		return toObj;
	}
}