public class  RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer noOfContacts,String testLastName){
        List<Contact> conts = new List<Contact>();
        for(Integer i=0;i<noOfContacts;i++){
            Contact c=new Contact();
            c.FirstName = 'test first '+i;
            c.LastName= testLastname+i;
            conts.add(c);
            
        }
        //insert conts;
        return conts;
    }

}