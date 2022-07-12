public class EmailNotifyOnContactClass {
    public static void sendEmail(List<Contact> contacts){
        System.debug(contacts);
        for(Contact newCont : contacts){
            if(newCont.Click_to_Send_mail__c == true){
            List<EmailTemplate> lstEmailTemplates = [SELECT Id, Body, Subject from EmailTemplate where DeveloperName = 'register_user'];
            Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
            mail1.setTemplateId(lstEmailTemplates[0].Id);
            mail1.setSaveAsActivity(false);
            mail1.setTargetObjectId(newCont.Id);// Any contact or User id of your record
            mail1.setToAddresses(new List<String>  {newCont.Email});
            //mail1.setWhatId(c.Id); // Enter your record Id whose merge field you want to add in template
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
            System.debug('verified');
            }
            else{
            List<EmailTemplate> lstEmailTemplates = [SELECT Id, Body, Subject from EmailTemplate where DeveloperName = 'unregister'];
            Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
            mail1.setTemplateId(lstEmailTemplates[0].Id);
            mail1.setSaveAsActivity(false);
            mail1.setTargetObjectId(newCont.Id);// Any contact or User id of your record
            mail1.setToAddresses(new List<String>  {newCont.Email});
            //mail1.setWhatId(c.id); // Enter your record Id whose merge field you want to add in template
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
            }
        }
    }
    public static void sendEmailAfterUpdate(List<Contact> contacts1 ){
        System.debug('starting');
        for(Contact newCont : contacts1){
            Contact oldContact = (Contact) Trigger.oldMap.get(newCont.Id);
            System.debug(newCont.id + '********' + oldContact.id);
            System.debug(oldContact); 
            System.debug(oldContact.LastName);
            System.debug(newCont.LastName);
            if(newCont.Click_to_Send_mail__c == true){
            List<EmailTemplate> lstEmailTemplates = [SELECT Id, Body, Subject from EmailTemplate where DeveloperName = 'register_user'];
            Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
            mail1.setTemplateId(lstEmailTemplates[0].Id);
            mail1.setSaveAsActivity(false);
            mail1.setTargetObjectId(newCont.Id);// Any contact or User id of your record
            mail1.setToAddresses(new List<String>  {newCont.Email});
            //mail1.setWhatId(c.Id); // Enter your record Id whose merge field you want to add in template
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
                if(oldContact.mail_was_Sent__c == newCont.mail_was_Sent__c){
                   // newCont.mail_was_Sent__c = true;
                }
            System.debug('verified');
            }
            else{
            List<EmailTemplate> lstEmailTemplates = [SELECT Id, Body, Subject from EmailTemplate where DeveloperName = 'unregister'];
            Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
            mail1.setTemplateId(lstEmailTemplates[0].Id);
            mail1.setSaveAsActivity(false);
            mail1.setTargetObjectId(newCont.Id);// Any contact or User id of your record
            mail1.setToAddresses(new List<String>  {newCont.Email});
            //mail1.setWhatId(c.id); // Enter your record Id whose merge field you want to add in template
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
                if(oldContact.mail_was_Sent__c == newCont.mail_was_Sent__c){
                  // newCont.mail_was_Sent__c = false;
                }
            }
        }    }
       

}