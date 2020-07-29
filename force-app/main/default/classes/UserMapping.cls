public without sharing class UserMapping {

    public static String mappingProcess = 'UserToContact';

    @future
    public static void updateContacts(Set<Id> uIds) {
        UserMapping uth = new UserMapping(uIds);
        uth.userIDs = uIds;
        uth.doItAll();
    }

    public UserMapping(Set<Id> uIds) {
        userIDs = uIds;
    }

    public Set<Id> userIDs {get{
        if(userIDs == null) userIDs = new Set<Id>();
        return userIDs;
    }set;}

    public Map<Id,Contact> consMap {get{
        if(consMap == null) consMap = new Map<Id,Contact>();
        return consMap;
    }set;}

    public List<User> us {get{
        if(us == null) us = new List<User>();
        return us;
    }set;}

    public List<Contact> consToUpsert {get{
        if(consToUpsert == null) consToUpsert = new List<Contact>();
        return consToUpsert;
    }set;}

    public UserMapping doItAll() {
        try {
            populateUsers().populateContactsMap().mapUsersToContacts();
            if(!consToUpsert.isEmpty()) {
                makeSureUsersOwnTheirOwnContacts();
                upsert consToUpsert;
            }
        } catch (Exception e) {}
        return this;
    }

    private UserMapping populateUsers() {
        us = Database.query(MappingUtil.getProcess(mappingProcess).grabFromBaseQuery() + ' Id IN:userIDs ORDER BY Id ASC');
        return this;
    }

    private UserMapping populateContactsMap() {
        consMap = new Map<Id,Contact>();
        for(Contact con:Database.query(MappingUtil.getProcess(mappingProcess).grabToBaseQuery() + ' User__c IN:userIDs ORDER BY User__c ASC')) {
            consMap.put(con.User__c, con);
        }
        return this;
    }

    private UserMapping makeSureUsersOwnTheirOwnContacts() {
        if(!consToUpsert.isEmpty()) {
            for(Contact conToUpsert:consToUpsert) {
                conToUpsert.OwnerId = conToUpsert.User__c;
            }
        }
        return this;
    }

    private UserMapping mapUsersToContacts() {
        for(User u:us) {
            if(!consMap.containsKey(u.Id)) {
                consMap.put(u.Id,new Contact());
            }
            consToUpsert.add((Contact)MappingUtil.doIt(mappingProcess,u,consMap.get(u.Id)));
        }
        return this;
    }
}