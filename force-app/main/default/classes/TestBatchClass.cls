public class TestBatchClass implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id,LastName from Contact');
    }
    public void execute(Database.BatchableContext bc, List<Contact> contacts){
        for(Contact c : contacts){
            c.LastName = 'batchclass test   '+ c.LastName;
        }
        update contacts;
        //System.debug(contacts[0]);
        
    }
    public void finish(Database.BatchableContext bc){
        System.debug('updated contacts');   
    }

}