public class GetAccountRecordsClass {
    @AuraEnabled
    public static List<Account> getMyAccountRecords(){
        List<Account> accounts = [SELECT Id,Name,Phone,Type FROM Account ORDER BY  Name];
        Return accounts;
    }
     @AuraEnabled
    public static List<Account> getMyAccountRecordsDesc(){
        List<Account> accounts = [SELECT Id,Name,Phone,Type FROM Account ORDER BY  Name DESC];
        Return accounts;
    }
    @AuraEnabled
    public static List<Account> saveAccount(List<Account> lstAccount) {
        system.debug('****'+lstAccount);
        try{  
            update lstAccount;
           }
        catch(Exception e){
               system.debug('******'+e.getMessage());
           }
        return lstAccount;
    }
     @AuraEnabled
    public static List<Account> delAccount(String[] lstAccountId){
        System.debug(lstAccountId);
        string msg='';
        List<Account> lstAcc=[SELECT Id,Name,Phone,Type FROM Account WHERE Id IN: lstAccountId];
        try{
            if(lstAcc.size()>0)
                System.debug('jajhfkjah');
                delete lstAcc;
            msg='deleted';
        }
        catch(Exception ex){
            msg=ex.getMessage()+'\n'+ex.getLineNumber()+'\n'+ex.getCause();
        }
        System.debug(lstAcc);
        System.debug(lstAcc);
        List<Account> lstAcc1=[SELECT Id,Name,Phone,Type FROM Account ORDER BY  Name];
        System.debug(lstAcc1.size());
        return lstAcc1;
        
         
    }
}