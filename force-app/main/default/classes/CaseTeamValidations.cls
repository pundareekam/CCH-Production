public without sharing class CaseTeamValidations {

	public Map<Id,Case> oldMap;
	public Map<Id,Case> newMap;
	public Map<String,Set<String>> validationRulesMap;
	public Map<Id,List<CaseTeamMember>> teamMembersMap;
	public static Set<Id> validationsDone;
	public static Set<Id> grabValidationsDone() {
		if(validationsDone == null) validationsDone = new Set<Id>();
		return validationsDone;
	}

	public CaseTeamValidations(Map<Id,Case> om, Map<Id,Case> nm) {
		oldMap = om;
		newMap = nm;
	}

	public CaseTeamValidations runValidations() {
		populateTeamMembersMap();
		populateValidationRuleMap();
		List<String> errorsTemp;
		if(!teamMembersMap.isEmpty()) {
			for(Case newCase:newMap.values()) {
				if(!grabValidationsDone().contains(newCase.Id) && teamMembersMap.containsKey(newCase.Id)) {
					for(CaseTeamMember ctm:teamMembersMap.get(newCase.Id)) {
						if(ctm.MemberId == UserInfo.getUserId() && validationRulesMap.containsKey(cleanStr(ctm.TeamRole.Name))) {
							errorsTemp = new List<String>();
							for(String fieldName:new List<String>(validationRulesMap.get(cleanStr(ctm.TeamRole.Name)))) {
								if(newCase.get(fieldName) != oldMap.get(newCase.Id).get(fieldName)) {
									errorsTemp.add(SObjectType.Case.fields.getMap().get(fieldName).getDescribe().getLabel());
								}
							}
							if(!errorsTemp.isEmpty()) {
								newCase.addError(
									'You do not have the permissions to make updates to ' + 
									(errorsTemp.size() > 1 ? 'the following fields: ' : '')  +
									String.join(errorsTemp,'; ')
								);
							}
						}
					}
					grabValidationsDone().add(newCase.Id);
				}
			}
		}
		errorsTemp = null;
		return this;
	}

	public CaseTeamValidations populateValidationRuleMap() {
		validationRulesMap = new Map<String,Set<String>>();
		Set<String> tempSet;
		String tempStr;
		for(Case_Team_Validation__mdt ctv:[
			SELECT 	Field_Name__c, Team_Role_s__c
			FROM 	Case_Team_Validation__mdt
		]) {
			tempSet = new Set<String>();
			for(String split:ctv.Team_Role_s__c.split('\n')) {
				if(String.isNotBlank(split)) {
					tempStr = cleanStr(split);
					System.debug(tempStr);
					if(String.isNotBlank(tempStr)) {
						tempSet.add(tempStr);
					}
				}
			}
			if(!tempSet.isEmpty()) {
				for(String caseRoleName:new List<String>(tempSet)) {
					if(SObjectType.Case.fields.getMap().containsKey(cleanStr(ctv.Field_Name__c))) {
						if(validationRulesMap.containsKey(caseRoleName)) {
							validationRulesMap.get(caseRoleName).add(cleanStr(ctv.Field_Name__c));
						} else {
							validationRulesMap.put(caseRoleName,new Set<String>{cleanStr(ctv.Field_Name__c)});
						}
					}
				}
			}
		}
		return this;
	}

	public static String cleanStr(String str) {
		return str.replaceAll('[\\s]','').toLowerCase();
	}

	public CaseTeamValidations populateTeamMembersMap() {
		teamMembersMap = Case_TH.getTeamMembersMap();
		return this;
	}
}