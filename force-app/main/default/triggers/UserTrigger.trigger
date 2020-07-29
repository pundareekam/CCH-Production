trigger UserTrigger on User (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	TriggerFactory.initialize(User.SObjectType);
}