public class UpdateLeadAfterClass {
    public static void updateLead(List<lead> leads){
        List<Lead> le = new List<Lead>();
        for(Lead l : leads){
            if(l.Industry=='Finance'){
            	Lead lead = new Lead();
                lead.id=l.id;
            	lead.LastName = 'trigger' + l.LastName;
            	le.add(lead);
            }
        }
        update le;
    }

}