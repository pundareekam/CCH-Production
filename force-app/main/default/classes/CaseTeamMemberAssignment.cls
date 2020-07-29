public without sharing class CaseTeamMemberAssignment {

	private Map<Id,Case> oldMap;
	private Map<Id,Case> newMap;
	private static Map<String,Map<String,String>> rolesToFieldMap;

	private static Map<String,String> getRolesToField(String recordTypeName) {
		if(rolesToFieldMap == null) {
			rolesToFieldMap = new Map<String,Map<String,String>>();
			String tempRTN;
			for(Case_Team_Member_Assignment__mdt ctma:[
				SELECT 	Case_Record_Types__c, Case_Team_Role_Name__c, User_Lookup_Field__c 
				FROM 	Case_Team_Member_Assignment__mdt
			]) {
				for(String rtn:ctma.Case_Record_Types__c.split('\n')) {
					tempRTN = rtn.replaceAll('[\\s]+','').replaceAll('\r','');
					if(rolesToFieldMap.containsKey(rtn)) {
						rolesToFieldMap.get(rtn).put(ctma.Case_Team_Role_Name__c, ctma.User_Lookup_Field__c);
					} else {
						rolesToFieldMap.put(rtn,new Map<String,String>{ctma.Case_Team_Role_Name__c => ctma.User_Lookup_Field__c});
					}
				}
			}
		}
		return rolestoFieldMap.containsKey(recordTypeName) ? rolestoFieldMap.get(recordTypeName) : null;
	}

	// made static so we can all share
	private static Map<Id,Id> contactToUserMap;

	public static Set<Id> assignmentsDone = new Set<Id>();
	public static Set<Id> grabAssignmentsDone() {
		if(assignmentsDone == null) assignmentsDone = new Set<Id>();
		return assignmentsDone;
	}

	public CaseTeamMemberAssignment(Map<Id,Case> om, Map<Id,Case> nm) {
		oldMap = om;
		newMap = nm;
	}

	public CaseTeamMemberAssignment populateContactIdToUserIdMap() {
		contactToUserMap = new Map<Id,Id>();
		Set<Id> contactsToQuery = new Set<Id>();
		for(Case c:newMap.values()) {
			if(!grabAssignmentsDone().contains(c.Id) && String.isNotBlank(c.ContactId)) contactsToQuery.add(c.ContactId);
		}
		if(contactsToQuery != null && !contactsToQuery.isEmpty()) {
			for(Contact con:[SELECT Id,User__c FROM Contact WHERE Id IN:contactsToQuery]) if(String.isNotBlank(con.User__c)) contactToUserMap.put(con.Id,con.User__c);
		}
		return this;
	}

	public class CheckCTM {

		public Map<String,String> populatedLookup {get{
			if(populatedLookup == null) populatedLookup = new Map<String,String>();
			return populatedLookup;
		}set;}

		public Map<String,String> ctmExists {get{
			if(ctmExists == null) ctmExists = new Map<String,String>();
			return ctmExists;
		}set;}

		public CheckCTM() {
			for(String roleName:new List<String>(getRolesToField(Case_TH.getRecordTypeIdToName().get('Grievance')).keySet())) {
				populatedLookup.put(roleName,'');
				ctmExists.put(roleName,'');
			}
		}

		public CheckCTM(Case c) {
			for(String roleName:new List<String>(getRolesToField(Case_TH.getRecordTypeIdToName().get(c.RecordTypeId)).keySet())) {
				populatedLookup.put(roleName,'');
				ctmExists.put(roleName,'');
			}
			checkLookups(c);
		}

		public CheckCTM checkLookups(Case c) {
			for(String roleName:new List<String>(populatedLookup.keySet())) {
				if(getRolesToField(Case_TH.getRecordTypeIdToName().get(c.RecordTypeId)).get(roleName) == 'ContactId') {
					if(String.isNotBlank(c.ContactId) && contactToUserMap.containsKey(c.ContactId)) populatedLookup.put(roleName,contactToUserMap.get(c.ContactId));
				} else {
					if(c.get(getRolesToField(Case_TH.getRecordTypeIdToName().get(c.RecordTypeId)).get(roleName)) != null) populatedLookup.put(roleName, (String)c.get(getRolesToField(Case_TH.getRecordTypeIdToName().get(c.RecordTypeId)).get(roleName)));
				}
			}
			return this;
		}

		public CheckCTM checkCTMs(List<CaseTeamMember> ctms) {
			if(ctms != null && !ctms.isEmpty()) {
				for(CaseTeamMember ctm:ctms) {
					if(ctmExists.containsKey(ctm.TeamRole.Name)) {
						ctmExists.put(ctm.TeamRole.Name, ctm.MemberId);
					}
				}
			}
			return this;
		}

		public List<CaseTeamMember> createTeamMembers(Id caseId) {
			List<CaseTeamMember> ctmsNew = new List<CaseTeamMember>();
			try {
				Set<String> ctmSet = new Set<String>();
				for(String existsId:ctmExists.values()) {
					if(String.isNotBlank(existsId)) ctmSet.add(existsId);
				}
				for(String roleName:new List<String>(populatedLookup.keySet())) {
					if(String.isNotBlank(populatedLookup.get(roleName)) && !ctmSet.contains(populatedLookup.get(roleName))) {
						ctmsNew.add(new CaseTeamMember(
							MemberId = populatedLookup.get(roleName),
							ParentId = caseId,
							TeamRoleId = Case_TH.getCaseTeamRoleMap().get(roleName)
						));
					}
				}
			} catch(Exception e) {}
			return ctmsNew;
		}
	}

	public List<CaseTeamMember> getNewOrUpdateCaseTeamMembers() {
		List<CaseTeamMember> newOrUpdate = new List<CaseTeamMember>();
		try {
			populateContactIdToUserIdMap();
			List<CaseTeamMember> tempList;
			CheckCTM tempCheck;
			for(Case c:newMap.values()) {
				if(!grabAssignmentsDone().contains(c.Id)) {
					tempList = new List<CaseTeamMember>();
					tempCheck = new CheckCTM(c);
					tempCheck.checkLookups(c);
					if(Case_TH.getTeamMembersMap().containsKey(c.Id)) tempCheck.checkCTMs(Case_TH.getTeamMembersMap().get(c.Id));
					tempList = tempCheck.createTeamMembers(c.Id);
					if(tempList != null && !tempList.isEmpty()) newOrUpdate.addAll(tempList);
					grabAssignmentsDone().add(c.Id);
				}
			}
			tempCheck = null;
			tempList = null;
		} catch(Exception e) {}
		return newOrUpdate;
	}
}