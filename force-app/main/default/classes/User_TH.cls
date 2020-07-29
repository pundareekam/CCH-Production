public with sharing class User_TH extends TriggerBase {

/* =========================== Static Properties =========================== */

	public static Set<Id> usersAlreadyMapped;

	public static Set<Id> grabUsersAlreadyMapped() {
		if(usersAlreadyMapped == null) usersAlreadyMapped = new Set<Id>();
		return usersAlreadyMapped;
	}

	public static Boolean userHasNotBeenMapped(Id userId) {
		return !grabUsersAlreadyMapped().contains(userId);
	}

	public static void addIdsToMappingRecursionCheck(Set<Id> userIds) {
		grabUsersAlreadyMapped().addAll(userIds);
	}

/* =========================== Basic Trigger Handling =========================== */

	public User_TH() {}

	public override void afterInsert() {
		userMapping();
	}

	public override void afterUpdate() {
		userMapping();
	}

/* =========================== Specific Logic =========================== */

	public User_TH userMapping() {
		Set<Id> sendToMapping = new Set<Id>();
		for(Id userId:new List<Id>(Trigger.newMap.keySet())) {
			if(userHasNotBeenMapped(userId)) {
				sendToMapping.add(userId);
			}
		}
		if(!sendToMapping.isEmpty()) {
			UserMapping.updateContacts(sendToMapping);
			addIdsToMappingRecursionCheck(sendToMapping);
		}
		return this;
	}
}