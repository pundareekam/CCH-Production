public without sharing class CaseMapping {
    

	public ENUM MapProcType {CONTACTTOCASE,CASETOCASESUMMARY}

	public List<Case> RelevantCases;
	public List<Case> CurrentCases;

	public Set<Id> contactIds;
	public Set<Id> caseIds;

	public MapProcType CurrentProcessType;

	public Map<Id,Contact> contactMap;
	public Map<Id,Case_Summary__c> caseSummaryMap;

	public static Map<String,String> recordType_ContactToCase;
	public static Map<String,String> recordType_CaseToCaseSummary;
	public static Map<String,String> getRTtoProcessMap(MapProcType processType) {
		if(recordType_ContactToCase == null || recordType_CaseToCaseSummary == null) {
			recordType_ContactToCase = new Map<String,String>();
			recordType_CaseToCaseSummary = new Map<String,String>();
			for(Case_Process_Mapping__mdt cpm:[
				SELECT Case_Record_Type_NEW__c, DeveloperName 
				FROM Case_Process_Mapping__mdt
			]) {
				if(cpm.DeveloperName.contains('ContactToCase')) {
					recordType_ContactToCase.put(
						cpm.Case_Record_Type_NEW__c,
						cpm.DeveloperName
					);
				} else if(cpm.DeveloperName.contains('CaseToCaseSummary')) {
					recordType_CaseToCaseSummary.put(
						cpm.Case_Record_Type_NEW__c,
						cpm.DeveloperName
					);
				}
			}
		}
		return processType == MapProcType.CONTACTTOCASE ? recordType_ContactToCase : recordType_CaseToCaseSummary;
	}

/* =========================== Constructor =========================== */

	public CaseMapping(List<Case> cases, MapProcType processType) {

		CurrentCases = cases;
		CurrentProcessType = processType;
	}

/* =========================== Process Classes =========================== */

	public CaseMapping runProcess() {
		if(CurrentProcessType == MapProcType.CONTACTTOCASE) {
			runContactToCaseProcess();
		} else if(CurrentProcessType == MapProcType.CASETOCASESUMMARY) {
			runCaseToCaseSummary();
		}
		return this;
	}

	public CaseMapping runContactToCaseProcess() {
		System.debug('Checking incoming records...');
		RelevantCases = new List<Case>();
		Set<Id> contactIds = new Set<Id>();
		for(Case c:CurrentCases) {
			if(String.isNotBlank(c.ContactId) && Case_TH.getRecordTypeIdToName().containsKey(c.RecordTypeId) && !c.isClosed) {
				if(getRTtoProcessMap(
					MapProcType.CONTACTTOCASE
				).containsKey(
					Case_TH.getRecordTypeIdToName().get(c.RecordTypeId)
				)) {
					RelevantCases.add(c);
					contactIds.add(c.ContactId);
				}
			}
		}
		populateContactMap(contactIds);
		contactIds = null;
		String processName;
		for(Case c:RelevantCases) {
			processName = getRTtoProcessMap(MapProcType.CONTACTTOCASE).get(Case_TH.getRecordTypeIdToName().get(c.RecordTypeId));
			c = (Case)MappingUtil.doIt(processName, contactMap.get(c.ContactId), c);
		}
		processName = null;
		return this;
	}

	public CaseMapping runCaseToCaseSummary() {
		populateCaseSummaryMap();
		String processName;
		List<Case_Summary__c> newUpdatedCaseSummaries = new List<Case_Summary__c>();
		for(Case c:CurrentCases) {
			if(
				getRTtoProcessMap(
					MapProcType.CASETOCASESUMMARY
				).containsKey(
					Case_TH.getRecordTypeIdToName().get(c.RecordTypeId)
				)
			) {
				processName = getRTtoProcessMap(MapProcType.CASETOCASESUMMARY).get(Case_TH.getRecordTypeIdToName().get(c.RecordTypeId));
				newUpdatedCaseSummaries.add((Case_Summary__c)MappingUtil.doIt(processName,c,caseSummaryMap.containsKey(c.Id) ? caseSummaryMap.get(c.Id) : new Case_Summary__c()));
			}
			processName = null;
		}
        System.debug('NEW UPDATED CASE SUMMARIES');
        System.debug(newUpdatedCaseSummaries);
		if(!newUpdatedCaseSummaries.isEmpty()) {
            try { 
                upsert newUpdatedCaseSummaries;
            }
            catch(DmlException e) {
            	System.debug('ERROR:' + e);
            }
		}
		newUpdatedCaseSummaries = null;
		return this;
	}

/* =========================== Helper Methods =========================== */

	public CaseMapping populateContactMap(Set<Id> contactIds) {
		if(contactIds != null && !contactIds.isEmpty()) {
			Set<String> contactFieldsSet = new Set<String>{'Id'};
			for(Field_Mapping__mdt fm:[
				SELECT 	From_Field__c, From_Object__c 
				FROM 	Field_Mapping__mdt 
				WHERE 	From_Object__c = 'Contact'
			]) {
				contactFieldsSet.add(fm.From_Field__c);
			}
			String contactFields = String.join(new List<String>(contactFieldsSet),', ');
			contactMap = new Map<Id,Contact>((List<Contact>)Database.query(
				'SELECT ' + contactFields + ' FROM Contact WHERE Id IN:contactIds'
			));
			contactFieldsSet = null;
			contactFields = null;
		}
		return this;
	}

	public CaseMapping populateCaseSummaryMap() {
		Set<Id> caseIds = (new Map<Id,Case>(CurrentCases)).keySet();
		Set<String> caseSummaryFieldsSet = new Set<String>{'Id'};
		for(Field_Mapping__mdt fm:[
			SELECT 	To_Field__c, To_Object__c 
			FROM 	Field_Mapping__mdt 
			WHERE 	To_Object__c = 'Case_Summary__c'
		]) {
			caseSummaryFieldsSet.add(fm.To_Field__c);
		}
		caseSummaryMap = new Map<Id,Case_Summary__c>();
		String caseSummaryFields = String.join(new List<String>(caseSummaryFieldsSet),', ');
		for(Case_Summary__c cs:(List<Case_Summary__c>)Database.query(
			'SELECT ' + caseSummaryFields + ' FROM Case_Summary__c WHERE Case__c IN:caseIds'
		)) {
			caseSummaryMap.put(cs.Case__c, cs);
		}
		caseIds = null;
		return this;
	}
}