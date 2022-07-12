public class LeadProcessor implements Database.Batchable<sObject> {
    public  Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id,LeadSource from lead');
   }
    public  void execute(Database.BatchableContext bc, List<lead> leads){
        for(Lead l:leads){
            l.LeadSource = 'DreamForce';
        }
        update leads;
    }
    public  void finish(Database.BatchableContext bc){
        System.debug('update finish');
    }
}