public without sharing class Case_TH extends TriggerBase {

/* =========================== Static Properties =========================== */

	public static Map<Id,List<CaseTeamMember>> teamMembersMap;

	public static Map<Id,String> recordTypeIdToName;
	public static Map<Id,String> getRecordTypeIdToName() {
		if(recordTypeIdToName == null) {
			recordTypeIdToName = new Map<Id,String>();
			for(RecordType rt:[
				SELECT 	Id, DeveloperName 
				FROM 	RecordType 
				WHERE 	SObjectType = 'Case'
			]) {
				recordTypeIdToName.put(rt.Id, rt.DeveloperName);
			}
			System.debug('RecordTypeNames: ' + String.join(recordTypeIdToName.values(),'; '));
		}
		return recordTypeIdToName;
	}

	public static Map<Id,List<CaseTeamMember>> getTeamMembersMap() {
		if(teamMembersMap == null) populateTeamMembersMap();
		return teamMembersMap;
	}

	public static void populateTeamMembersMap() {
		teamMembersMap = new Map<Id,List<CaseTeamMember>>();
		for(CaseTeamMember ctm:[
			SELECT 	Id, ParentId, MemberId, TeamRole.Name
			FROM 	CaseTeamMember 
			WHERE 	ParentId IN:Trigger.newMap.keySet()
		]) {
			if(teamMembersMap.containsKey(ctm.ParentId)) {
				teamMembersMap.get(ctm.ParentId).add(ctm);
			} else {
				teamMembersMap.put(ctm.ParentId,new List<CaseTeamMember>{ctm});
			}
		}
		System.debug('TeamMembersMap: '+ JSON.serialize(teamMembersMap.values()));
	}

	public static Map<String,Id> caseTeamRoleMap;
	public static Map<String,Id> getCaseTeamRoleMap() {
		if(caseTeamRoleMap == null) populateCaseTeamRoleMap();
		return caseTeamRoleMap;
	}
	public static void populateCaseTeamRoleMap() {
		caseTeamRoleMap = new Map<String,Id>();
		for(CaseTeamRole ctr:[SELECT Id, Name FROM CaseTeamRole]) {
			caseTeamRoleMap.put(ctr.Name, ctr.Id);
		}
	}

	public static Set<Id> casesAlreadyUpdated;
	public static Set<Id> getCasesAlreadyUpdated() {
		if(casesAlreadyUpdated == null) casesAlreadyUpdated = new Set<Id>();
		return casesAlreadyUpdated;
	}

	public static Boolean caseHasNotBeenUpdated(Id caseId) {
		return !getCasesAlreadyUpdated().contains(caseId);
	}

/* =========================== Basic Trigger Handling =========================== */

	public Case_TH() {}

	public override void beforeInsert() {
		contactToCaseMapping_NEW();
        updCaseSubject();
	}

	public override void afterInsert() {
		populateTeamMembersMap();
		createUpdateCaseSummaries_NEW();
		createCaseTeamMembers();
	}

	public override void afterUpdate() {
		createUpdateCaseSummaries_NEW();
		createCaseTeamMembers();
	}

	public override void beforeUpdate() {
		contactToCaseMapping_NEW();
		populateTeamMembersMap();
		runCustomValidations();
        updCaseSubject();
	}

/* =========================== Specific Logic Methods =========================== */

	public Case_TH contactToCaseMapping_NEW() {
		CaseMapping cm = new CaseMapping((List<Case>)Trigger.new, CaseMapping.MapProcType.CONTACTTOCASE);
		cm.runProcess();
		return this;
	}

	private Case_TH createUpdateCaseSummaries_NEW() {
		CaseMapping cm = new CaseMapping((List<Case>)Trigger.new, CaseMapping.MapProcType.CASETOCASESUMMARY);
		cm.runProcess();
		return this;
	}

	public Case_TH createCaseTeamMembers() {
		CaseTeamMemberAssignment ctma = new CaseTeamMemberAssignment((Map<Id,Case>)Trigger.oldMap, (Map<Id,Case>)Trigger.newMap);
		List<CaseTeamMember> newList = ctma.getNewOrUpdateCaseTeamMembers();
		if(newList != null && !newList.isEmpty()) {
			bulkUpserts.addAll((List<SObject>)newList);
		}
		ctma = null;
		return this;
	}

	public Case_TH runCustomValidations() {
		CaseTeamValidations ctv = new CaseTeamValidations((Map<Id,Case>)Trigger.oldMap, (Map<Id,Case>)Trigger.newMap);
		ctv.runValidations();
		ctv = null;
		return this;
	}
    
    public void updCaseSubject() {
        UpdateCaseSubject ucs = new UpdateCaseSubject((List<Case>)Trigger.new);
    }
}