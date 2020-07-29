@isTest
private class Tuition_Reimbursement_Flow_New_TEST {
  @isTest static void simpleTest() {
    Account a = new Account(Name='CCH Temp Attachment Account');
   insert a;
    Attachment doc = new Attachment();
    doc.Name = 'test Document';
    doc.Description = 'Test Description';
  //  doc.ParentId = a.Id;
      doc.Body = Blob.valueOf('test data');
 //   insert doc;
    

    
      Tuition_Reimbursement_Flow_New vfc = new Tuition_Reimbursement_Flow_New();
//    vfc.x_flow = new Flow.Interview.Tuition_Reimbursement( new Map<String, Object>() );
//    vfc.x_flow.start(); 
    Pagereference testPage = Page.Tuition_Reimbursement_Flow_VFP;
      
    Test.setCurrentPage(testPage);
    vfc.doc = doc;
   
    System.debug(vfc.showUpload);
    
    System.debug(vfc.redirectToCase);

    System.debug(vfc.saveDocument());
      
    vfc.transferAttchmentstoCase();
	
         
    System.debug(vfc.x_flow);
      

  }
}