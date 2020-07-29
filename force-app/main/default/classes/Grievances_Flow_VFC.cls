public class Grievances_Flow_VFC extends FlowBase {

        public Flow.Interview.Grievances x_flow {get;set;}

        private String getRedirectURL() {
                return '/' + (!isEmployeeUser && x_flow != null && String.isNotBlank(x_flow.CaseID) ? x_flow.CaseID : 'home/home.jsp');
        }

        public PageReference redirectToCase {get{
                PageReference pageRef = new PageReference(getRedirectURL());
                pageRef.setRedirect(true);
                return pageRef;
        }}
}