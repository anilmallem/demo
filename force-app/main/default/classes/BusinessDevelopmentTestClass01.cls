@isTest
public class BusinessDevelopmentTestClass01 {
    @isTest
    public static void testBdm(){
       Id p = [select id from profile where name='Customer Community Plus Login User'].id;
       
        Account ac = new Account(name ='Grazitti') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='testCon',AccountId = ac.Id);
        insert con;                   
        User user = new User(alias = 'test123', email='anil.mallem@raagvitech.com',
                emailencodingkey='UTF-8', lastname=con.LastName, languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
        insert user;
        System.debug(user);       
        List<BDM_Assignment__mdt> metData = new List<BDM_Assignment__mdt>();
        list<User> users=[SELECT Id,LastName,contactId FROM User WHERE Id =:user.id];
        System.debug(users);
        
        
        System.runAs(user) {
        
        List<BDM_Assignment__mdt> records = BusinessDevelopmentClass01.fetchRecords();
        // System.debug(records);
        // List<BDM_Assignment__mdt> records = new  List<BDM_Assignment__mdt>();
        System.assertEquals('partners@cricket.com', records[0].Email__c);
        }  
     }
    @isTest
    public static void testBdm1(){
        System.debug('2 testing');
       Id p = [select id from profile where name='Customer Community Plus Login User'].id;
       
        Account ac = new Account(name ='hello') ;
        insert ac; 
       
        Contact con = new Contact(LastName ='testCon1',BDM_Assignment__c='BDM-Sachin Tendulkar',AccountId = ac.Id);
        insert con;                   
        User user = new User(alias = 'test1233', email='anil.mallem@raagvitech.com',
                emailencodingkey='UTF-8', lastname=con.LastName, languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='tester1@noemail.com');
        insert user;
        System.debug(user);       
        List<BDM_Assignment__mdt> metData = new List<BDM_Assignment__mdt>();
        list<User> users=[SELECT Id,LastName,contactId FROM User WHERE Id =:user.id];
        System.debug(users);
        
        System.runAs(user) {
        List<BDM_Assignment__mdt> records = BusinessDevelopmentClass01.fetchRecords();
            System.assertEquals('sachin@cricket.com', records[0].Email__c);
        }  
     }


}