public with sharing class FlowLaunch_VFC {

	public static String flowVFPBase = '%_Flow_VFP';

	public List<ApexPage> flowsList {get{
		if(flowsList == null) flowsList = new List<ApexPage>();
		return flowsList;
	}set;}

	public User CurrentUser {get{
		if(CurrentUser == null) CurrentUser = queryCurrentUser();
		return CurrentUser;
	}set;}

	public FlowLaunch_VFC() {
		queryFlowVFPs();
	}

	private User queryCurrentUser() {
		return [
			SELECT 	Id, Profile.Name, UserRole.DeveloperName, Union_Representative__c, Is_Union__c 
			FROM 	User 
			WHERE 	Id =: UserInfo.getUserId()
		];
	}

	public FlowLaunch_VFC queryFlowVFPs() {
		flowsList = [
			SELECT 	Id, Name, MasterLabel, Description
			FROM 	ApexPage 
			WHERE 	Name LIKE:flowVFPBase
			ORDER BY MasterLabel ASC
		];
		return this;
	}
}