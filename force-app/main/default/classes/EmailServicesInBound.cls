global class EmailServicesInBound implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        try{
            List<EmailMessage> emsg= new List<EmailMessage>();
            List<String> s = new List<String>();
            List<EmailMessage> checkfromadd = [Select FromAddress,parentId from EmailMessage Where FromAddress =:email.fromAddress];
            System.debug(checkfromadd);
            for(EmailMessage e: checkfromadd){
                s.add(e.FromAddress);                       
            }
            if(s.contains(email.fromAddress)){
                system.debug('inside if');
                System.debug('Subject>>>>>>>>>>>>>>>>>'+email.subject);
                EmailMessage em = new EmailMessage();
                em.FromAddress = email.fromAddress;
                em.ToAddress = email.toAddresses[0];
                em.ParentId = checkfromadd[0].ParentId;
                em.Subject = email.subject;
                insert em;
                
                
            }
            else{
                System.debug('inside else');
                //String caseId = EmailServicesInBound.getCasseId(email.subject);
                //System.debug(caseId);
                
                // System.debug('CaseNumber'+caseNumber);
                String fromAdd=email.fromAddress;
                Contact[] con=[Select Id,email from Contact where email=:fromAdd];
                Case c=new Case();
                System.debug(con);
                list<Case> cases = new List<Case>();
                
                // for(Contact ct : con){
                if(con.size()>1 ){
                    c.Origin='Email';
                    c.Priority='High';
                    c.ContactId=con[0].Id;
                    c.Status='New';
                    c.Description=email.plainTextBody;
                    c.Subject=email.subject;
                    c.Mutiple_Accounts_Contact__c=true;
                    insert c;
                    Emailmessage emailmsg = new EmailMessage();
                    emailmsg.Subject = email.subject;
                    emailmsg.FromAddress=email.fromAddress;
                    emailmsg.ToAddress = email.toAddresses[0];
                    emailmsg.ParentId = c.Id;
                    emsg.add(emailmsg);
                    insert emsg;
                }
                c.Origin='Email';
                c.Priority='High';
                c.ContactId=con[0].Id;
                c.Status='New';
                c.Description=email.plainTextBody;
                c.Subject=email.subject;
                
                insert c;
                Emailmessage emailmsg = new EmailMessage();
                emailmsg.Subject = email.subject;
                emailmsg.FromAddress=email.fromAddress;
                emailmsg.ToAddress = email.toAddresses[0];
                emailmsg.ParentId = c.Id;
                emsg.add(emailmsg);
                insert emsg;
                
                
                List<Messaging.InboundEmail.BinaryAttachment> binaryAttachments = email.binaryAttachments;
                List<Attachment> attachments = new List<Attachment>();
                for(Case c1 : cases){
                    for(Messaging.InboundEmail.binaryAttachment b : binaryAttachments){
                        Attachment a= new Attachment();
                        a.ParentId = c1.Id;
                        a.Body = b.body;
                        a.name=b.fileName;
                        attachments.add(a);
                    }
                }
                Insert attachments;
                result.success=true;
            }
        }
        
        catch(Exception e){
            result.success=false;
        }
        return result;
    }
   
    
}