public virtual class FlowBase {

    public String selectedDoc {get;set;}

    public Document doc {get{
        if(doc == null) doc = new Document();
        return doc;
    }set;}

    public List<DocWrapper> docs {get{
        if(docs == null) docs = new List<DocWrapper>();
        return docs;
    }set;}

    public List<String> docNames {get{
        if(docNames == null) docNames = new List<String>();
        return docNames;
    }set;}

    public Set<Id> docIds {get{
        if(docIds == null) docIds = new Set<Id>();
        return docIds;
    }set;}

    public Boolean isEmployeeUser {get{
        return currentUser.UserRole.DeveloperName == 'Employee';
    }}

    public User currentUser {get{
        if(currentUser == null) currentUser = queryCurrentUser();
        return currentUser;
    }set;}

    private User queryCurrentUser() {
        return [
            SELECT  Id, Name, UserRole.Name, UserRole.DeveloperName, UserRoleId,
                    Profile.Name, ProfileId
            FROM    User
            WHERE   Id =:UserInfo.getUserId()
        ];
    }

    public PageReference saveDocument() {
        if(String.isNotBlank(doc.Name)) {
            doc.AuthorId = UserInfo.getUserId();
            doc.FolderId = UserInfo.getUserId();
            if(String.isNotBlank(doc.Description) && doc.Description.length() > Document.Description.getDescribe().getLength()) {
                doc.Description = doc.Description.subString(0,Document.Description.getDescribe().getLength()-3) + '...';
            }
            insert doc;
            docNames.add(doc.Name);
            docIds.add(doc.Id);
            docs.add(new DocWrapper(doc));
            doc = new Document();
        }
        return null;
    }

    public PageReference deleteDoc() {
        if(String.isNotBlank(selectedDoc)) {
            for(Integer i = 0; i < docs.size(); i++) {
                if(docs[i].doc.Id == selectedDoc) {
                    delete docs[i].doc;
                    docs.remove(i);
                    break;
                }
            }
        }
        return null;
    }

    public class DocWrapper {
        public Boolean selected {get;set;}
        {selected = false;}
        public Document doc {get;set;}
        public DocWrapper(Document d) {
            this.doc = d;
            this.doc.Body = null;
        }
    }
}