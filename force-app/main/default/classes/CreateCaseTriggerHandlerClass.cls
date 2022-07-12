public class CreateCaseTriggerHandlerClass {
    public static void createCase(List<Residential_Mortgage__c> records){
        List<Case> caseList = new List<Case>();
        Id typeId = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Send_Case_Notification'].Id;
        List<Messaging.CustomNotification> customNotificationList = new List<Messaging.CustomNotification>();
        for(Residential_Mortgage__c rm : records){
            Case c = new Case();
            c.Origin = 'email';
            c.Subject = rm.Subject__c;
            c.OwnerId = rm.Under_Writter__c;
            caseList.add(c);
            //FeedItem objPost = new FeedItem();
            //objPost.ParentId = rm.Under_Writter__c;
            //objPost.Body = 'Hello there from APEX';
            //insert objPost;
        }
      
            insert caseList;
         if(!caseList.isEmpty()){
            for(Case caseObj : caseList){
                Messaging.CustomNotification notification = new Messaging.CustomNotification();
                notification.setBody('Case Created');
                System.debug('case number is>>>>>>>>'+caseObj.CaseNumber);
                notification.setTitle('One case is created in your Profile. The Case No is ' + caseObj.Id);
                notification.setSenderId(caseObj.OwnerId);
                notification.setNotificationTypeId(typeId);
                notification.setTargetId(caseObj.id); // target object id
                //customNotificationList.add();
                notification.send(new Set<String> { caseObj.OwnerId }); // target user id.
               
            }
           
        }
        
    }
    
}