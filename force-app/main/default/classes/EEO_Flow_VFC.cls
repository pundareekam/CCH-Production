public class EEO_Flow_VFC extends FlowBase {

    public Flow.Interview.EEO x_flow {get;set;}

    public Boolean showUpload {get{
        Boolean showIt = false;
        try { showIt = x_flow != null && (Boolean)x_flow.getVariableValue('ShowUpload'); } catch(Exception e) {}
        return showIt;
    }}

    private String getRedirectURL() {
        return '/' + (!isEmployeeUser && x_flow != null && String.isNotBlank(x_flow.CaseID) ? x_flow.CaseID : 'home/home.jsp');
    }

    public PageReference redirectToCase {get{
        PageReference pageRef = new PageReference(getRedirectURL());
        pageRef.setRedirect(true);
        return pageRef;
    }}
}