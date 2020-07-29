public class Exit_Packet_Flow_VFC extends FlowBase {

    public Flow.Interview.Exit_Packet x_flow {get;set;}
    
    public Boolean showUpload {get{
        Boolean showIt = false;
        try { showIt = x_flow != null && (Boolean)x_flow.getVariableValue('ShowUpload'); } catch(Exception e) {}
        return showIt;
    }}

    private String getRedirectURL() {
        String urlStr = '/apex/Exit_Packet_Flow_VFP';
        if(x_flow != null && x_flow.CaseID != null) urlStr = '/apex/SaveCaseDocs_VFP?id='+x_flow.CaseID + (docIds != null && !docIds.isEmpty() ? '&docIds='+String.join(new List<Id>(docIds),'_') : '');
        return urlStr;
    }

    public PageReference redirectToCase {get{
        PageReference pageRef = new PageReference(getRedirectURL());
        pageRef.setRedirect(true);
        return pageRef;
    }}
}