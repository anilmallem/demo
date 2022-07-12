public class BusinessDevelopmentClass01 {
    @AuraEnabled
    public static List<BDM_Assignment__mdt> fetchRecords(){
        List<BDM_Assignment__mdt> records = new List<BDM_Assignment__mdt>();
        Id userId = UserInfo.getUserId();
        System.debug('UserId' +userId);
        User u = [select id,contactId from User where id = : userId];
        System.debug(u);
        Id getContactId = u.contactId;
        system.debug('getContactId' + getContactId);
        Contact contacts = [SELECT BDM_Assignment__c FROM Contact WHERE id= :getContactId];
        System.debug(contacts);
        if(contacts.BDM_Assignment__c != null){
        BDM_Assignment__mdt records1 = [SELECT Id, Email__c,API_Image__c,Phone__c, Label,Name__c,Heading__c,Role__c 
                                        FROM BDM_Assignment__mdt
                                        WHERE Label =:contacts.BDM_Assignment__c];
            records.add(records1);
        }
        else{
            BDM_Assignment__mdt records1 = [SELECT Id, Email__c,API_Image__c,Phone__c, Label,Name__c,Heading__c,Role__c 
                                            FROM BDM_Assignment__mdt
                                            WHERE Label =:'none'];
            records.add(records1);
        }
        
    
        system.debug(records);
       
        return records;
        
    }

}