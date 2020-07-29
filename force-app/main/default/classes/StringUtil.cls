/*
	Developed Internally at Rightpoint
	* Pete O'Connell
	* poconnell@rightpoint.com
	* Created 2016/05/11
*/
global class StringUtil {

	global class StringUtilException extends Exception {}

	// used enumerated values so only the values are available
	global enum RandOpts {ALPHAUPPER,ALPHALOWER,NUMBERS,SYMBOLS}

	// gives options of what kind of random string someone is looking for
	private static String alphabetUpper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	private static String alphabetLower = alphabetUpper.toLowerCase();
	private static String numbers = '0123456789';
	private static String symbols = '!#$%&()*+,-.:;<=>?@[]^_{|}~';

	// maps work faster than long if statements
	global static Map<RandOpts,String> RandMap = new Map<RandOpts,String>{
		RandOpts.ALPHAUPPER => alphabetUpper,
		RandOpts.ALPHALOWER => alphabetLower,
		RandOpts.NUMBERS => numbers,
		RandOpts.SYMBOLS => symbols
	};

	// the random number seed will be an 8 digit integer
	public static Integer generateSeed() {
        return Math.round(Math.random()*10000000);
    }

    // this restricts the upper limit of the random number
	public static Integer getBoundedRandomNumber(Integer upperLimit) {
		return Math.mod(generateSeed(), upperLimit);
	}

	// uses only letters to generate string of characters
	global static String getRandomStringLetters(Integer strLength) {
		return getRandomString(new List<RandOpts>{RandOpts.ALPHAUPPER,RandOpts.ALPHALOWER},strLength);
	}

	// this method allows someone to pick and choose how to create a random string of characters
	global static String getRandomString(List<RandOpts> options, Integer stringLength) {
		// a string to build result on
		String randomString = '';
		// a string of characters to choose from
		String charactersToChooseFrom = '';
		// add all of the character options to the string of chracters to choose from
		for(RandOpts option:options) {
			charactersToChooseFrom += RandMap.get(option);
		}
		// random number is out of the loop for performance's sake
		Integer randomNumber;
		for(Integer i = 0; i < stringLength; i++) {
			// get a random number that's within the range of possible characters
			randomNumber = getBoundedRandomNumber(charactersToChooseFrom.length());
			// grab the substring from the chracters to choose from and add it to the growing result
			randomString += charactersToChooseFrom.substring(randomNumber, randomNumber+1);
		}
		// return the result of random characters
		return randomString;
	}
}