@isTest
public class UpdateFlinksDocumentsBatchTest {
    @isTest
    public static void testFlickDoc(){
        
       // List<Residential_Mortgage__c> rmObjList = new List<Residential_Mortgage__c>{
       //     new Residential_Mortgage__c(Name = 'testRMObject'),
       //         new Residential_Mortgage__c(Name = 'testRMObject1'),
        //         new Residential_Mortgage__c(Name = 'testRMObject2')   
        //};
         //   insert rmObjList;
        
        Residential_Mortgage__c rmObj = new Residential_Mortgage__c();
        rmObj.Name = 'testRMObject';
        INSERT rmObj;
        
        InstaShare_Request__c instShareObj = new InstaShare_Request__c();
        instShareObj.Name = 'check testing';
        instShareObj.Residential_Mortgage__c = rmObj.Id;
        INSERT instShareObj;
        
        ContentVersion cv = new ContentVersion(
            Title = 'Some document',
            PathOnClient = 'some document.txt',
            VersionData = Blob.valueOf('Checking for the RM object field named FlickDocument')
        );
        INSERT cv;
        
        ContentDocument cd = [SELECT Id FROM ContentDocument WHERE LatestPublishedVersionId = :cv.Id];
        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = cd.Id,
            LinkedEntityId = instShareObj.Id
        );
        insert cdl;
        Test.startTest();
        UpdateFlinksDocumentsBatch m = new UpdateFlinksDocumentsBatch();
        Database.executeBatch(m);
        Test.stopTest();
        Residential_Mortgage__c rmObject = [SELECT Id,Flinks_Documents__c FROM Residential_Mortgage__c WHERE Name =: 'testRMObject'];
        System.debug('test checkbox>>>>>>>>>>>>.'+rmObject.Flinks_Documents__c);
        System.assertEquals(true, rmObject.Flinks_Documents__c);
    }  
}