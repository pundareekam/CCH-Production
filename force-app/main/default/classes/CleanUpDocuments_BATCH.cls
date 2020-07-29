/*
	Scheduable batch class that cleans up documents in personal document folders
	This is necessary due to the upload in flow functionality (FlowBase, SaveCaseDocs_VFC)
*/
global class CleanUpDocuments_BATCH implements Database.Batchable<sObject>, Schedulable {

	String query;

	// constructor
	global CleanUpDocuments_BATCH() {
		query = 'SELECT Id FROM Document WHERE FolderId IN (SELECT Id FROM User WHERE isActive = true) AND CreatedDate < TODAY';
	}

	// preps the batch process
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator(query);
	}

	// working methods
   	global void execute(Database.BatchableContext bc, List<sObject> scope) {
		if(scope != null && !scope.isEmpty()) delete scope;
	}

	// allows this class to be scheduable
	global void execute(SchedulableContext sc) {
		CleanUpDocuments_BATCH cud_b = new CleanUpDocuments_BATCH();
		Database.executeBatch(cud_b);
	}

	global void finish(Database.BatchableContext bc) {
		System.debug('finished');
	}
}