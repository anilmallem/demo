public class MYHelloWorld {
    public static void multiplyCharge(Energy_Audit__c[] energy){
        for (Energy_Audit__c e : energy){
            e.Average_Annual_Electric_Cost__c = e.Average_Annual_Electric_Cost__c*5;
        }
    }

}