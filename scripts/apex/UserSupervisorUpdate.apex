Map<Id,User> users = new Map<Id, User>([SELECT Id, Name, EmployeeID__c, Supervisor__c, SupervisorEmployeeID__c, SupervisorFirstName__c, SupervisorLastName__c FROM User Where isActive = true AND LastModifiedDate > 2020-07-14T00:00:00Z ]);
List<User> updateUsers = new List<User>();
for (User u : users.values()) {
    if (users.containsKey(u.Supervisor__c) && (u.SupervisorEmployeeID__c != users.get(u.Supervisor__c).SupervisorEmployeeID__c)) {
        u.SupervisorEmployeeID__c = users.get(u.Supervisor__c).SupervisorEmployeeID__c;
        u.SupervisorFirstName__c = users.get(u.Supervisor__c).SupervisorFirstName__c;
        u.SupervisorLastName__c = users.get(u.Supervisor__c).SupervisorLastName__c;
        updateUsers.add(u);
        System.debug('User Updated'+u);
    }
}
update updateUsers;

