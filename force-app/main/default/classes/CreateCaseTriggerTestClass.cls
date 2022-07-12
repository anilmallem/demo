@isTest
public class CreateCaseTriggerTestClass {
    @isTest
    public static void testNotification(){
        String s;
        Id typeId = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Send_Case_Notification'].Id;
        List<Residential_Mortgage__c> listRmg = new List<Residential_Mortgage__c>();
        User users = [ SELECT Id, ProfileId,Name FROM User Where Name =:'Test Bell Notification 02'];
        Residential_Mortgage__c rmg = new Residential_Mortgage__c();
        rmg.Under_Writter__c = users.Id;
        rmg.Subject__c = 'Hello 123';
        listRmg.add(rmg);
        insert listRmg;
        
        Case caseObj = [SELECT Id,Subject,CaseNumber,OwnerId from case where subject=:rmg.Subject__c]; 
               
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
       
        notification.setBody('Case Created');
        System.debug('case number is>>>>>>>>'+caseObj.CaseNumber);
        notification.setTitle('One case is created in your Profile. The Case No is ' + caseObj.Id);
        notification.setSenderId(caseObj.OwnerId);
        notification.setNotificationTypeId(typeId);
        notification.setTargetId(caseObj.id); // target object id
        //customNotificationList.add();
        notification.send(new Set<String> { caseObj.OwnerId }); // target user id.
       
        
       // CreateCaseTriggerHandlerClass.createCase(listRmg);
        System.assertEquals('Hello 123',caseObj.Subject );
    }
    
}