/**
* @File Name          : BusinessDevelopmentClass.cls
* @Description        : To show Details of BDM.
* @Author             : Anil Mallem 
* @Group              : 
* @Last Modified By   : Anil Mallem
* @Last Modified On   : 15/03/2022
* @Modification Log   : 
* Ver       Date            Author      		    Modification
* 1.0    11/03/2022         Anil Mallem              Initial Version
**/
public class BusinessDevelopmentClass {
    @AuraEnabled
    public static List<BDM_Assignment__mdt> fetchRecords(){
        List<Contact> contacts = [SELECT BDM_Assignment__c FROM Contact WHERE Lastname= :'customer check'];
        System.debug(contacts);
        List<BDM_Assignment__mdt> records = new List<BDM_Assignment__mdt>();
        for(Contact c: contacts){
            if(c.BDM_Assignment__c == 'BDM-Sachin Tendulkar'){
                BDM_Assignment__mdt bdmlist = [SELECT Id, Email__c,API_Image__c,Phone__c, Label,Name__c,Heading__c,Role__c from BDM_Assignment__mdt WHERE Label = : c.BDM_Assignment__c ];
                System.debug(bdmlist);
                records.add(bdmlist);
            }
            else if(c.BDM_Assignment__c == 'BDM-Jaheer khan'){
                BDM_Assignment__mdt bdmlist = [SELECT Id, Email__c,API_Image__c,Phone__c, Label,Name__c,Heading__c,Role__c from BDM_Assignment__mdt WHERE Label = : c.BDM_Assignment__c ];
                System.debug(bdmlist);
                records.add(bdmlist);
            }
            else if(c.BDM_Assignment__c == 'BDM-M S Dhoni'){
                BDM_Assignment__mdt bdmlist = [SELECT Id, Email__c,API_Image__c,Phone__c, Label,Name__c,Heading__c,Role__c from BDM_Assignment__mdt WHERE Label = : c.BDM_Assignment__c ];
                System.debug(bdmlist);
                records.add(bdmlist);
            }
            else if (c.BDM_Assignment__c == 'BDM-Virat Kohli'){
                BDM_Assignment__mdt bdmlist = [SELECT Id, Email__c,API_Image__c,Phone__c, Label,Name__c,Heading__c,Role__c from BDM_Assignment__mdt WHERE Label = : c.BDM_Assignment__c ];
                System.debug(bdmlist);
                records.add(bdmlist);
            }
            else if(c.BDM_Assignment__c == null){
                BDM_Assignment__mdt bdmlist = [SELECT Id, Email__c,API_Image__c,Phone__c, Label,Name__c,Heading__c,Role__c from BDM_Assignment__mdt WHERE Label = :'none' ];
                records.add(bdmlist);
            }
          
        }
        system.debug(records);
       
        return records;
        
    }

}