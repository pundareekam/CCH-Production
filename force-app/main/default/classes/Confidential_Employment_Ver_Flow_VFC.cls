public class Confidential_Employment_Ver_Flow_VFC extends FlowBase {

    public Flow.Interview.Confidential_Employment_Ver x_flow {get;set;}

    public Boolean showUpload {get{
        Boolean showIt = false;
        try { showIt = x_flow != null && (Boolean)x_flow.getVariableValue('ShowUpload'); } catch(Exception e) {}
        return showIt;
    }}

    private String getRedirectURL() {
        String urlStr = '/apex/Confidential_Employment_Ver_Flow_VFP';
        if(x_flow != null && x_flow.CaseID != null) urlStr = '/apex/SaveCaseDocs_VFP?id='+x_flow.CaseID + (docIds != null && !docIds.isEmpty() ? '&docIds='+String.join(new List<Id>(docIds),'_') : '');
        return urlStr;
    }

    public PageReference redirectToCase {get{
        PageReference pageRef = new PageReference(getRedirectURL());
        pageRef.setRedirect(true);
        return pageRef;
    }}
}