public class GetFilesClass {
    @auraEnabled
    public static list<ContentDistribution> getAllDetailsOfFiles(){
       List<ContentDocumentLink> idList=  [SELECT ContentDocumentId, LinkedEntityId  
            			  FROM ContentDocumentLink 
                          WHERE LinkedEntityId in ( SELECT Id FROM Contact ) and LinkedEntity.Type='Contact'];
        
        List<Id> ContentDocumentIdList = new List<Id>();
        for(ContentDocumentLink cId : idList){
            ContentDocumentIdList.add(cId.ContentDocumentId);
        }
        system.debug(ContentDocumentIdList);
       List<ContentVersion> data= [SELECT ContentVersion.Title,ContentVersion.FileType 
                           FROM ContentVersion 
                           WHERE ContentDocumentId IN : ContentDocumentIdList];
     // List<ContentDistribution> datalinks = [Select Id, DistributionPublicUrl  FROM ContentDistribution WHERE ContentDocumentId IN :ContentDocumentIdList];
      // return data;
       List<ContentDistribution> datalinks = [SELECT Id,Name,ContentVersionId,ContentVersion.FileType, ContentVersion.Title, 
                                            ContentVersion.FileExtension,ContentDocumentId,DistributionPublicUrl
                                            FROM ContentDistribution  
                                            WHERE ContentDocumentId IN :ContentDocumentIdList];
       system.debug(datalinks);
       return datalinks;
        
    }

}