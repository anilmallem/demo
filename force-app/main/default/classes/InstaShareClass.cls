public class InstaShareClass {
    @AuraEnabled
    public static instaShareRecordWrapper fetchrecords(){
        List<Id> recordIds = new List<Id>();
        List<Id> documentIds = new List<Id>();
        Map<Id,List<Id>> mapOfRecordIdsToFilesIds = new Map<Id,List<Id>>();
        List<InstaShare_Request__c> records = [Select Id, Name,Email__c,Status__c from InstaShare_Request__c];
        for(InstaShare_Request__c r:records){
            recordIds.add(r.Id);
        }
        List<ContentDocumentLink> files=[SELECT Id, LinkedEntityId, ContentDocumentId,ContentDocument.title, ShareType
                                         FROM ContentDocumentLink 
                                         where LinkedEntityId IN :recordIds];
        for(ContentDocumentLink filesId : files){
            documentIds.add(filesId.Id);
            if(mapOfRecordIdsToFilesIds.containsKey(filesId.LinkedEntityId)){
                                                       mapOfRecordIdsToFilesIds.get(filesId.LinkedEntityId).add(filesId.ContentDocumentId);
                                                    }
                                                    else{
                                                        mapOfRecordIdsToFilesIds.put(filesId.LinkedEntityId,new list<Id>{filesId.ContentDocumentId});
                                                    }
    
        }
        System.debug('files'+files);
        System.debug('records'+records);
        instaShareRecordWrapper WrapperClass = new instaShareRecordWrapper();
        WrapperClass.instaShareReqRecords=records;
        WrapperClass.instaShareDocumentsRecords=documentIds;
        WrapperClass.mapOfIdToContDocId=mapOfRecordIdsToFilesIds;
        System.debug('records>>>>>>>>>>>>>>.'+records);
        System.debug('documentIds>>>>>>>>>>>>>>.'+documentIds);
        System.debug('mapOfRecordIdsToFilesIds>>>>>>>>>>>>>>.'+mapOfRecordIdsToFilesIds);
        
        return WrapperClass;
    }
    
    public class instaShareRecordWrapper{
        @AuraEnabled
        public List<InstaShare_Request__c> instaShareReqRecords;
        @AuraEnabled
        public List<Id> instaShareDocumentsRecords;
        @AuraEnabled
        public Map<Id,List<Id>> mapOfIdToContDocId;
    }
    
    

}