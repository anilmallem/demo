@isTest
public class TestRestrictContactByName {
    @isTest static void createContact(){
        Contact c= new Contact(LastName='INVALIDNAME');
        c.LastName='INVALIDNAME';
        Database.SaveResult result = Database.insert(c, false);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
                             result.getErrors()[0].getMessage());
    }

}