public class EscalCase {
    //Apex properties or variables

    public Id owner {get; set;}
    public Id Id { get; set; }
    public Id CaseId { get; set; }
    public EmailMessage emsg { get; set; }

    //constructor to get the Case record
    
    public EscalCase(ApexPages.StandardController controller) {
    emsg  =  (EmailMessage)controller.getRecord();
    //owner = emsg.ParentId;
    
    System.debug('The Email message record: ' + emsg);
    //owner = cas.OwnerId;
   
    }

    //Method that can is called from the Visual Force page action attribute
   // @InvocableMethod(label='Prevent EmailMessage Deletion01' description='EmailMessage Deletion')
   public PageReference caseEscalation() {
       System.debug('Start Method');
       System.debug(owner);
       Case c=[Select Id,RecordTypeId from Case Where Id = :owner];
       Id FirstRecId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('First').getRecordTypeId();
       RecordType[] rtp =[Select Id,DeveloperName From RecordType ];
       System.debug(rtp);
       System.debug('C.recordtype id'+c.RecordTypeId);
       System.debug('FirstRecId'+FirstRecId);
       PageReference newPage;
       //for(RecordType r:rtp){
           if(c.RecordTypeId == FirstRecId){
               newPage = Page.newVf;
              // PageReference pageRef = new PageReference('/'+Id);
              // pageRef.setRedirect(true);
               System.debug('inside if');
               //return pageRef;
           }
           
       //}
       	return newPage.setRedirect(true);
       //System.debug('Case Owner: ' + owner);
        //System.debug('Case Id: ' + Id);
        //build your code logic here
       
        //Returns to the case page
    }
}