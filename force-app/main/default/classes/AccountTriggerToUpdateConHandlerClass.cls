public class AccountTriggerToUpdateConHandlerClass {
    public static void updatePhone(map<Id,Account> mapOfAcc){
        Set<Id> ids = mapOfAcc.keySet();
        
        List<Contact> con = [SELECT Id,Name,Phone,AccountId,Account.Name FROM Contact WHERE AccountId in: mapOfAcc.keySet()];
        for(Contact eachCon : con){
            if(mapOfAcc.containsKey(eachCon.AccountId)){
                eachCon.Phone = (mapOfAcc.get(eachCon.AccountId)).Phone;
            }
        }
        update con;
    }

}