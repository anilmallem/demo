/**
* @File Name          : TestUserTrigger.apxc
* @Description        : To Test UserTrigger.apxt
* @Author             : Anil Mallem 
* @Group              : 
* @Last Modified By   : Anil Kumar
* @Last Modified On   : 01/03/2022
* @Modification Log   : 
* Ver       Date            Author      		    Modification
* 1.0    01/03/2022         Anil Mallem              Initial Version
**/
@isTest
public class TestUserTrigger {
    @isTest static void testInsertUser(){
        // Create a new Object User
         User insertUser1 = new User(); 
         insertUser1.FirstName = 'Bheema';
         insertUser1.LastName = 'Nayak';
         insertUser1.Alias = 'rakr1212';
         insertuser1.Email = 'anil.mallem@raagvitech.com';
         insertUser1.Username = 'siridana56123@gmail.com';
         insertUser1.ProfileId= '00e5j0000016PhhAAE';
         insertUser1.TimeZoneSidKey = 'America/Los_Angeles';
         insertUser1.LocaleSidKey = ' en_US';
         insertUser1.EmailEncodingKey = 'UTF-8';
         insertUser1.LanguageLocaleKey = 'en_US';
        // Perform test
        Test.startTest();
        insert insertUser1;
        Test.stopTest();
        //Retriveing data from database and compare
        User nickname = [SELECT Id,CommunityNickname FROM User WHERE Id =: insertUser1.id];
        System.assertEquals('BN[3]', nickname.CommunityNickname);
    }
}