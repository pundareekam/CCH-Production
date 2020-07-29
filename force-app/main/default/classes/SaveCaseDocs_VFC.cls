public class SaveCaseDocs_VFC {

    public List<DocWrapper> docs {get{
        if(docs == null) docs = new List<DocWrapper>();
        return docs;
    }set;}

    public Id caseID {get{
        if(String.isBlank(caseID)) caseID = '';
        return caseID;
    }set;}

    public Integer successes {get{
        if(successes == null) successes = 0;
        return successes;
    }set;}

    public Integer failures {get{
        if(failures == null) failures = 0;
        return failures;
    }set;}

    public SaveCaseDocs_VFC() {
        String docIdsStr = ApexPages.currentPage().getParameters().get('docIds');
        String caseIdStr = ApexPages.currentPage().getParameters().get('id');
        if(String.isNotBlank(docIdsStr) && String.isNotBlank(caseIdStr)) {
            for(String docId:docIdsStr.split('_')) {
                docs.add(new DocWrapper(docId.trim()));
            }
        }
        if(String.isNotBlank(caseIdStr)) {
            caseID = caseIdStr.trim();
        }
    }

    public PageReference doIt() {
        if(!docs.isEmpty()) {
            List<Document> docsToDelete = new List<Document>();
            for(DocWrapper doc:docs) {
                doc.makeAttachment(caseId);
                if(doc.success) {
                    docsToDelete.add(new Document(Id = doc.docId));
                    successes++;
                } else {
                    failures++;
                }
            }
            if(docsToDelete != null && !docsToDelete.isEmpty()) {
                delete docsToDelete;
            }
        }
        return null;
    }

    public class DocWrapper {

        public Id docId {get;set;}

        public Boolean success {get{
            if(success == null) success = false;
            return success;
        }set;}

        public DocWrapper(Id dId) {
            docId = dId;
        }

        public void makeAttachment(Id cId) {
            Document d = runQuery();
            try {
                if(d != null) {
                    insert new Attachment(
                        Name = d.Name,
                        Body = d.Body,
                        Description = d.Description,
                        ContentType = d.ContentType,
                        ParentId = cId,
                        OwnerId = UserInfo.getUserId()
                    );
                    success = true;
                }
            } catch(Exception e) {}
            d.Body = null;
        }

        public Document runQuery() {
            Document d;
            try {
                d = [
                    SELECT  Id, Name, Body, Description, ContentType 
                    FROM    Document 
                    WHERE   Id =:docId
                ];
            } catch(Exception e) {}
            return d;
        }
    }
}