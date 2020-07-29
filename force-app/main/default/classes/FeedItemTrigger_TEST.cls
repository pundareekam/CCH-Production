@isTest
private class FeedItemTrigger_TEST {
	@isTest static void simpleTest() {
		FeedItem fi = new FeedItem(Body = 'Testing all of the things please', ParentId = UserInfo.getUserId());
		insert fi;
		FeedComment fc = new FeedComment(FeedItemId = fi.Id,CommentBody = 'Testing all of the things is good');
		insert fc;
	}
}