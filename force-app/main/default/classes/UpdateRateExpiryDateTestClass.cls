@isTest
public class UpdateRateExpiryDateTestClass {
    @isTest   
    public static void updateDate(){
        
        //Inserting List of RM record
        List<Residential_Mortgage__c> listOfRm = New List<Residential_Mortgage__c>{
            new Residential_Mortgage__c(LMS_Loan_Number__c = '123',Purpose__c = 'Refinance',submitted_date__c = Date.parse('5/12/2022'),Loan_Status__c = 'Application',Commitment_Date__c = Date.parse('5/12/2022')),
                new Residential_Mortgage__c(LMS_Loan_Number__c = '456',Purpose__c = 'Purchase',submitted_date__c = Date.parse('5/12/2022'),Loan_Status__c = 'Application',Commitment_Date__c = Date.parse('5/12/2022')),
                new Residential_Mortgage__c(LMS_Loan_Number__c = '789',Purpose__c = 'Refinance',submitted_date__c = Date.parse('5/12/2022'),Loan_Status__c = 'Application',Commitment_Date__c = Date.parse('5/12/2022'),Rate_Expiry_Date__c =Date.parse('06/01/2022'))
                };
                    insert listOfRm;
        
        //Test class Started
        Test.startTest();
        UpdateRateExpiryDateClass1 m = new UpdateRateExpiryDateClass1();
        Database.executeBatch(m);
        Test.stopTest();
        //Test classs end
        Residential_Mortgage__c testdata = [Select Rate_Expiry_Date__c,submitted_date__c From Residential_Mortgage__c Where LMS_Loan_Number__c = '123'];
        
        System.assertEquals(Date.parse('7/11/2022'),testdata.Rate_Expiry_Date__c);
    }
    
}