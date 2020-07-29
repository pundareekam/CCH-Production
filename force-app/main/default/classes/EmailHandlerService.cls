global class EmailHandlerService Implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envolope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        System.debug(email);
        return null;
 	}
 }
/**
 global class EmailHandlerService Implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envolope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String accname = email.fromName;
        String accdes = email.plainTextBody;
        String accindus = email.Subject;
        Account ac = new Account(Name = accname, description = accdes, Industry = accindus);
        insert ac;
        return null;
    }}
**/