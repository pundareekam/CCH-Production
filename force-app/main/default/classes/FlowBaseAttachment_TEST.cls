@isTest
public class FlowBaseAttachment_TEST {

	@isTest static void simpleTest() {
        
		Account a = new Account(Name = 'CCH Temp Attachment Account');
        insert a;
        FlowBaseAttachment fb = new FlowBaseAttachment();

		if(fb.isEmployeeUser) System.debug('YAY is an employee');

		if(fb.doc != null) System.debug('YAY the doc is not null!!!');

		String blurb = 'blah';

		Integer multiplier = (Attachment.Description.getDescribe().getLength() / blurb.length()) + 1;

		List<String> descriptionList = new List<String>();
		for(Integer i = 0; i < multiplier; i++) {
			descriptionList.add(blurb);
		}

		fb.doc = new Attachment (
			Body = Blob.valueOf('Some Text'),
			ContentType = 'application/pdf',
		//	DeveloperName = 'my_document',
		//	IsPublic = true,
			Name = 'My Document',
		//	FolderId = UserInfo.getUserId(),
			Description = String.join(descriptionList,' ')
		);

		fb.saveDocument();

		fb.selectedDoc = fb.docs[0].doc.Id;
		fb.deleteDoc();
	}
}