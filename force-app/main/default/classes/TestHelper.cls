/*
	Developed Internally at Rightpoint
	* Pete O'Connell
	* poconnell@rightpoint.com
	* Created 2016/05/11

	Facilitates in generating data for test classes and wrapping them data up
	Currently, it is doing a lot of user generation; however, it should be
	written to include a lot more useful test creation methods.
*/
@isTest
global class TestHelper {

	// makes this class exceptional
	global class TestHelperException extends Exception {}

	// a test method inside a TestHelper test class.... GAH!
	public static testmethod void simpleTest() {
		TestHelper th = new TestHelper();
		th.runSetup();
		try {
			throw new TestHelperException('This is working');
		} catch(Exception e) {
			System.assert(e != null);
		}
	}

	// for simple test, one is all you need
	global User Admin {get;set;}

	// for more complicated tests, it's good to test all user profiles
	// and perhaps several user configurations
	public List<User> UserRecords {get{
		if(UserRecords == null) UserRecords = new List<User>();
		return UserRecords;
	}set;}

	// unique names are important
	global String x_UniqueName {get;set{
		x_UniqueName = value.length() > 40 ? value.subString(value.length() - 40,value.length()) : value;
	}}

	// a user record will be created for each profile name that is added to this list
	public List<String> UserProfileNames {get{
		if(UserProfileNames == null) UserProfileNames = new List<String>();
		return UserProfileNames;
	}set;}

	// CONSTRUCTORS!!!!
	global TestHelper() {
		this.x_UniqueName = StringUtil.getRandomStringLetters(40);
	}

	// THEY ARE PRETTY COOL... o_O
	global TestHelper(String feedMe) {
		this.x_UniqueName = feedMe;
	}

	// generates a random name... not a real green name: that's cruel
	public static String getRandomName() {
		return StringUtil.getRandomStringLetters(40);
	}

	// combines few things to one... efficiency
	global void runSetup() {
		if(Admin == null) createAdminUser();
		if(UserRecords.isEmpty()) createUserRecords();
	}

	// CREATE ONE USER
	global void createAdminUser() {
		createAdminUser(true);
	}

	// CREATE ADMIN USER WITH THE OPTION OF INSERTING ON CREATION
	global void createAdminUser(Boolean insertAdmin) {
		Profile p = [SELECT Id FROM profile WHERE name='System Administrator' LIMIT 1];
		String x_emailPrefix = x_UniqueName.replaceAll('[^A-Za-z0-9]','');
		String x_alias = x_emailPrefix.length() > 8 ? x_emailPrefix.subString(x_emailPrefix.length() - 8,x_emailPrefix.length()) : x_emailPrefix;
		Admin = new User(
			alias = x_alias,
			email = x_emailPrefix + '=test.com@cookcountyhhs.org',
			emailencodingkey = 'UTF-8', 
			lastname = x_UniqueName, 
			languagelocalekey = 'en_US',
			localesidkey = 'en_US', 
			profileid = p.Id,
			timezonesidkey = 'America/Chicago', 
			username = x_emailPrefix+'=test.com@cookcountyhhs.org.dev120'
		);
		if(insertAdmin) insert Admin;
	}

	// create many users and insert them
	public void createUserRecords() {
		createUserRecords(true);
	}

	// create many user records with option of inserting them... again, not real green names...
	public void createUserRecords(Boolean insertRecords) {
		// if no profile names have been specified, add the System Administrator profile
		if(UserProfileNames.isEmpty()) UserProfileNames.add('System Administrator');
		for(Profile p:[SELECT Id,Name FROM Profile WHERE Name IN:UserProfileNames]) { 
			UserRecords.add(makeUser(p.Id));
		}
		// if inserting is what you want, inserting is what you get
		if(insertRecords) insert UserRecords;
	}

	public static User makeUser(Id profileId) {
		String UniqueName = getRandomName();
		String EmailPrefix = UniqueName.replaceAll('[^A-Za-z0-9]','');
		String Alias = EmailPrefix.length() > 8 ? EmailPrefix.subString(EmailPrefix.length() - 8,EmailPrefix.length()) : EmailPrefix;
		return new User(
			Alias = Alias,
			Email = EmailPrefix + '=test.com@cookcountyhhs.org',
			EmailEncodingKey = 'UTF-8',
			LastName = UniqueName,
			FirstName = UniqueName.subString(0,20),
			LanguageLocaleKey = 'en_US',
			LocalesIdKey = 'en_US',
			ProfileId = profileId,
			TimezoneSidKey = 'America/Chicago',
			Username = EmailPrefix+'=test.com@cookcountyhhs.org.dev120'
		);
	}
}