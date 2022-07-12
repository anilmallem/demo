@isTest 
public class TestVerifyDate {
    @isTest static void checkingDates(){
        Date getDate= VerifyDate.CheckDates(Date.parse('12/27/1996'),Date.parse('12/30/1996'));
        System.assertEquals(Date.parse('12/30/1996'),getDate);
    }
    @isTest static void checkingDates1(){
        Date getDate1= VerifyDate.CheckDates(Date.parse('12/27/1996'),Date.parse('03/01/1997'));
        System.assertEquals(Date.parse('12/31/1996'),getDate1);
    }
    

}