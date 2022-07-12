global class UpdateFlinksDocumentsBatch implements Database.Batchable<sObject>,DataBase.Stateful {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        set<Id> setOfInstaIds = new set<Id>(); //Set of instashare IDs
        set<Id> setOfContentDocumentIds = new set<Id>();//Set of content document IDs
        
        
        for(InstaShare_Request__c eachInstaSharerecord : [SELECT Id,Name,Processed__c FROM InstaShare_Request__c WHERE Processed__c =: false and Residential_Mortgage__c != null]){
            setOfInstaIds.add(eachInstaSharerecord.Id);
        }
        //get All document List of related Instashare object records
        
        
        for(ContentDocumentLink eachContentDocId : [SELECT Id,ContentDocumentId,ContentDocument.Title,LinkedEntity.Name,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN: setOfInstaIds]){
            setOfContentDocumentIds.add(eachContentDocId.LinkedEntityId);
        }
        System.debug('setOfInstaIds>>>>>>>>>>>>>>>>..'+setOfInstaIds);
        System.debug('setOfContentDocumentIds>>>>>>>>>>>>>>'+setOfContentDocumentIds);
        
        
        //Returning the Instashare records having the files
        
        return Database.getQueryLocator([SELECT Id,Name,Residential_Mortgage__r.Id,	Unique_code__c,Residential_Mortgage__r.Under_Writter__c,Residential_Mortgage__r.LMS_Loan_Number__c,Residential_Mortgage__r.Broker__r.Name,Processed__c FROM InstaShare_Request__c WHERE Id IN: setOfContentDocumentIds]);
        
    }
    public void execute(Database.BatchableContext BC,List<InstaShare_Request__c> instShareList) {
        System.debug('Inside execute method');
        Map<Id,Id> getCaseIdandOwnerId = new Map<Id,Id>();
        Map<Id,string> InstaRecordsForNotif = New map<Id,string>();
        Map<Id,string> InstaRecords = New map<Id, String>();
        Map<string, Id> MapOfCases = new Map<string, Id>();
        set<Id> setOfInstaIds = new set<Id>();
        set<string> ownerId = new set<string>();
        set<Id> reqRMIds = new set<Id>(); //set of required residential mortgage IDs
        List<Residential_Mortgage__c> listOfRMobj = new List<Residential_Mortgage__c>();
        List<InstaShare_Request__c> listOfInsta = new List<InstaShare_Request__c>();
        List<Case> caseList = new List<Case>();
        List<Messaging.CustomNotification> customNotificationList = new List<Messaging.CustomNotification>();
        Id typeId = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Send_Case_Notification'].Id;
        try{
            //Messaging.CustomNotification notification = new Messaging.CustomNotification();
            
            //Adding the RM Object IDs into Set
            for(InstaShare_Request__c eachInstaRec : instShareList){
                if(eachInstaRec.Residential_Mortgage__c != null && eachInstaRec.Processed__c == false){
                    setOfInstaIds.add(eachInstaRec.Id);
                    reqRMIds.add(eachInstaRec.Residential_Mortgage__c);
                    eachInstaRec.Processed__c = true;
                    listOfInsta.add(eachInstaRec);
                    ownerId.add(eachInstaRec.Residential_Mortgage__r.Under_Writter__c);
                    Case caseObj = new Case();
                    caseObj.Unique_code__c = eachInstaRec.Unique_code__c;
                    caseObj.Subject = 'Flinks Documents - '+eachInstaRec.Residential_Mortgage__r.LMS_Loan_Number__c+ ' - ' +eachInstaRec.Residential_Mortgage__r.Broker__r.Name;
                    caseObj.OwnerId = eachInstaRec.Residential_Mortgage__r.Under_Writter__c;
                    caseList.add(caseObj);
                  
                    InstaRecords.put(eachInstaRec.Id,eachInstaRec.Unique_code__c);
                    InstaRecordsForNotif.put(eachInstaRec.id,eachInstaRec.Name);
                    
                    
                   // notification.setBody('Case created related to  for deal assigned.');
                    //notification.setTitle('One case is created in your Profile.');
                    //notification.setSenderId(eachInstaRec.Residential_Mortgage__r.Under_Writter__c);
                    //notification.setNotificationTypeId(typeId);
                    //notification.setTargetId(eachInstaRec.id); // target object id
                    //customNotificationList.add(notification);
                    
                    
                    
                }
                
            }
            //Updating the Instashare 
            if(!listOfInsta.isEmpty()){
                UPDATE listOfInsta; 
            }
            
            //Updating The RM Object
            for(Residential_Mortgage__c eachRMobj : [SELECT Id,	Under_Writter__c,LMS_Loan_Number__c,Broker__r.Id FROM Residential_Mortgage__c WHERE Id IN:reqRMIds]){
                eachRMobj.Flinks_Documents__c = true;
                listOfRMobj.add(eachRMobj);
                
                
                
            }
            if(!listOfRMobj.isEmpty()){
                UPDATE listOfRMobj; 
            }
            if(!caseList.isEmpty()){
                INSERT caseList; 
                //notification.send(ownerId);
                
            }
            for(Case iterateCase : caseList){
                MapOfCases.put(iterateCase.Unique_code__c,iterateCase.id);
                getCaseIdandOwnerId.put(iterateCase.id,iterateCase.OwnerId);
            }
            List<ContentDocumentLink> lstOfCD =  new List<ContentDocumentLink>();
            
            System.debug('Check Insta map>>>>>>>>>>>.'+InstaRecords);
            System.debug('Check Case map>>>>>>>>>>>>>>>>'+MapOfCases);
            for(Id key : InstaRecords.keyset()){
                for(ContentDocumentLink eachContentDocId : [SELECT Id,ContentDocumentId,ContentDocument.Title,LinkedEntity.Name,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: key]){
                    System.debug('check key>>>>>>>>>>>>>>>'+ MapOfCases.get(InstaRecords.get(key)));
                    eachContentDocId.Id = null;
                    eachContentDocId.LinkedEntityId = MapOfCases.get(InstaRecords.get(key));
                    System.debug('LinkedEntityId>>>>>>>>>>>>>..'+eachContentDocId.LinkedEntityId);
                    lstOfCD.add(eachContentDocId);
                    System.debug('lstOfCD>>>>>>>>>>>>>>.'+lstOfCD);
                }
                Messaging.CustomNotification notification = new Messaging.CustomNotification();
                 notification.setBody('Case created related to '+InstaRecordsForNotif.get(key)+ ' for deal assigned.');
                    notification.setTitle('One case is created in your Profile.');
                    notification.setSenderId(getCaseIdandOwnerId.get(MapOfCases.get(InstaRecords.get(key))));
                    notification.setNotificationTypeId(typeId);
                    notification.setTargetId(key); // target object id
                    notification.send(new Set<String> { getCaseIdandOwnerId.get(MapOfCases.get(InstaRecords.get(key)))});
                    
            }
            
            INSERT lstOfCD;
            
            
            
        }
        
        
        catch(Exception e){
            System.debug(e.getMessage());
        }
        
        
    }
    public void finish(Database.BatchableContext BC) {
    }
}