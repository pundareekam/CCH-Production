trigger FeedItemTrigger on FeedItem (before insert) {
    for(FeedItem fi:Trigger.new) {
    	if(!Test.isRunningTest()) fi.addError('Chatter comments are disabled');
    }
}