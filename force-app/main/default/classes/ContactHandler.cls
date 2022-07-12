public class ContactHandler {
    static boolean flag = true;
    public static void afterUpdate(set<Id> contactIds){
       // if(flag==true){
         //   flag=false;
        List<Contact> cnts = new List<Contact>();
        List<Contact> newC = [SELECT Id,mail_was_Sent__c,Click_to_Send_mail__c,Email FROM Contact WHERE Id in : contactIds ];
        for(Contact c : newC){
            if(c.Click_to_Send_mail__c == true){
               
                c.mail_was_Sent__c = true;
                cnts.add(c);
            }
            else{
                c.mail_was_Sent__c = false;
                cnts.add(c);
            }
        }
        update cnts;
   // }
    }

}