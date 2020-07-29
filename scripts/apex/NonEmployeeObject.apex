List<NonEmployee__c> nonEmployees = new List<NonEmployee__c>();
NonEmployee__c n = new NonEmployee__c(Name='Chris JOrdan',Email__c='test@test.com',phone__c='309-999-1234');
nonEmployees.add(n);
insert nonEmployees;