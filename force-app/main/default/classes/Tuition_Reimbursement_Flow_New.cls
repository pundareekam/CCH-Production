public class Tuition_Reimbursement_Flow_New extends FlowBaseAttachment {
    public Flow.Interview.Tuition_Reimbursement x_flow {get;set;}
    public Id contactId {get; set;}
    
    public Boolean showUpload {get{
        Boolean showIt = false;
        Boolean transferAttachments = false;
        try { 
            showIt = x_flow != null && (Boolean)x_flow.getVariableValue('ShowUpload');
            transferAttachments = x_flow != null && (Boolean)x_flow.getVariableValue('transferAttachmentstoCase');
            if ( showIt )
                contactId = (Id)x_flow.getVariableValue('ContactId'); 
            
        } catch(Exception e) { System.debug('Exception Occured when accessing Flow variables:     ' + e.getMessage());}
        if ( transferAttachments )
            transferAttchmentstoCase();
        return showIt;
    }}
    
    private String getRedirectURL() {
        // return '/' + (!isEmployeeUser && x_flow != null && String.isNotBlank(x_flow.CaseID) ? x_flow.CaseID : 'home/home.jsp');
     //   String urlStr = '/apex/Tuition_Reimbursement_Flow_VFP';
        String urlStr = '/home/home.jsp'; 
     //   if(x_flow != null && x_flow.CaseID != null) urlStr = '/apex/SaveCaseDocs_VFP?id='+x_flow.CaseID + (docIds != null && !docIds.isEmpty() ? '&docIds='+String.join(new List<Id>(docIds),'_') : '');
        return urlStr;
    }
    
    public PageReference redirectToCase {get{
        PageReference pageRef = new PageReference(getRedirectURL());
        pageRef.setRedirect(true);
        return pageRef;
    }}
    
    
    public Override PageReference saveDocument() {
        if(String.isNotBlank(doc.Name)) {
            If ( contactId == null ) {
                List<Account> tempAccounts = new List<Account>([Select Id from Account Where Name = 'CCH Temp Attachment Account' LIMIT 1]);
                for (Account a : tempAccounts)   
                { doc.ParentId = a.Id; }
            }
            else
                doc.ParentId = contactId;  
            
            doc.OWnerId = UserInfo.getUserId();
            doc.IsPrivate = false;
            
            if(String.isNotBlank(doc.Description) && doc.Description.length() > Attachment.Description.getDescribe().getLength()) {
                doc.Description = doc.Description.subString(0,Attachment.Description.getDescribe().getLength()-3) + '...';
            }
            insert doc;
            
            docNames.add(doc.Name);
            docIds.add(doc.Id);
            docs.add(new DocWrapper(doc));
            doc = new Attachment();
        }
        System.debug('Documents Saved Successfully :' + contactId);
        return null;
    }
    
    
    public void transferAttchmentstoCase () {
        
        Id caseId;
        try { 
            List<Attachment> attachments = new List<Attachment>();
            List<Attachment> attachmentsAcc = new List<Attachment>([SELECT Id, Body, Name, ContentType, OwnerId, IsPrivate, Description FROM Attachment WHERE Id IN :docIds]);
            for (Attachment  b : attachmentsAcc ) {
                Attachment c = new Attachment();
                //     c.ParentId = caseId;
                c.Body = b.Body;
                c.Name = b.Name;
                c.ContentType = b.ContentType;
                c.OwnerId = b.OwnerId;
                c.IsPrivate = b.IsPrivate;
                c.Description = b.Description;
                attachments.add(c);                
            }
            
            
            if ( x_flow == null )
                caseId = null;
            else
                caseId = (Id)x_flow.getVariableValue('CaseID');
            IF (caseId != null)
                for (Attachment  d : attachments ) 
            {      d.ParentId = caseId; }
            
            if ( attachments.size() > 0 && attachmentsAcc.size() > 0 ) {
                Insert attachments; // attach attachments to CaseID
                Delete attachmentsAcc; // remove attachements from Contact ID
            }
            
            
        } catch(DmlException e) {
            System.debug('The following DML exception has occurred: ' + e.getMessage());
        }  catch(Exception e) {
            System.debug('The following other than DML exception has occurred: ' + e.getMessage());
        }     
    }
}