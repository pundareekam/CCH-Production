trigger FeedCommentTrigger on FeedComment (before insert) {
    for(FeedComment fc:Trigger.new) {
        if(!Test.isRunningTest()) fc.addError('Chatter comments have been disabled');
    }
}