global class UpdateRateExpiryDateClass1 implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        Date__mdt dateValue = [SELECT RMDate__c FROM Date__mdt Where label ='ResMorDate' LIMIT 1];
        System.debug('dateValue'+dateValue.RMDate__c);
       // DateTime dT = dateValue.RMDate__c;
       // Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
       // String datevalue1 = String.valueOf(myDate);
       // System.debug('datevalue1>>>>>>>>>>.'+datevalue1);
       // string query = 'SELECT Id,LMS_Loan_Number__c,Purpose__c,submitted_date__c,Rate_Expiry_Date__c,Commitment_Date__c,CTC_Business_Days_To_Expiry_Notificatio__c FROM Residential_Mortgage__c Where Loan_Status__c in (\'Application\',\'Commitment\') AND (Rate_Expiry_Date__c = null OR CTC_Business_Days_To_Expiry_Notificatio__c = true) AND Purpose__c in (\'Refinance\',\'Purchase\') AND Commitment_Date__c >'+datevalue1;
       // System.debug('query'+query);
       // return Database.getQueryLocator(query);
        return Database.getQueryLocator([SELECT Id,LMS_Loan_Number__c,Purpose__c,submitted_date__c,Rate_Expiry_Date__c,Commitment_Date__c,CTC_Business_Days_To_Expiry_Notificatio__c FROM Residential_Mortgage__c WHERE Loan_Status__c in ('Application','Commitment')  AND Purpose__c in ('Refinance','Purchase') AND Commitment_Date__c >=: dateValue.RMDate__c]);
    }
    
    public void execute(Database.BatchableContext BC, List<Residential_Mortgage__c> dataList) {
        System.debug('inside execute method');
        
        List<Case> listCase = new List<Case>();
        List<Residential_Mortgage__c> rmObjList = new List<Residential_Mortgage__c>();
        Date__mdt dateValue = [SELECT RMDate__c FROM Date__mdt Where label ='ResMorDate' LIMIT 1];
        System.debug('dateValue'+dateValue.RMDate__c);
        
        try{
            System.debug('Get Data>>>>>>>>>>>>..'+dataList);
            for(Residential_Mortgage__c rm : dataList) { 
                System.debug('inside for');
                if(rm.Purpose__c == 'Refinance' && rm.submitted_date__c != null && rm.Commitment_Date__c >= dateValue.RMDate__c ){
                    System.debug('inside if');
                    Date getSubmittedDate = rm.submitted_date__c;
                    Date getRateExpiryDate = getSubmittedDate.addDays(60);
                    rm.Rate_Expiry_Date__c = getRateExpiryDate;
                    rmObjList.add(rm);
                    
                }
                else if(rm.Purpose__c == 'Purchase' && rm.submitted_date__c != null && rm.Commitment_Date__c >= dateValue.RMDate__c  ){
                    System.debug('inside if1');
                    Date getSubmittedDate = rm.submitted_date__c;
                    Date getRateExpiryDate = getSubmittedDate.addDays(90);
                    rm.Rate_Expiry_Date__c = getRateExpiryDate;
                    rmObjList.add(rm);
                }
                if(rm.CTC_Business_Days_To_Expiry_Notificatio__c == true)
                {
                    System.debug('Case  created');
                    Case cobj = new Case();
                    cobj.Subject = 'Case Created by Residentioal mortgage';
                    listCase.add(cobj);
                }
                
            }
            System.debug('SIze>>>>>>>>>>.'+rmObjList.size());
            if(!rmObjList.isEmpty()){
                update rmObjList;
            }
            if(!listCase.isEmpty()){
                insert listCase;
            }
            
        }
        catch(exception e){
            System.debug('Inside Catch');
            String s = e.getMessage();
            System.debug(s);
        }   
    }   
    
    public void finish(Database.BatchableContext BC) {
        
    }
    
}