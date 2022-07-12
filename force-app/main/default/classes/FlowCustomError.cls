public class FlowCustomError {
    
    public class CustomException extends Exception {}
    
    @InvocableMethod(label='Throw Custom Flow Exception')
    public static void throwCustomFlowException(Inputs[] input){
        
        throw createCustomException('An Internal Error has Occured '+input[0].message);
       
    }
    
    public class Inputs{
        @InvocableVariable(label='Error message')
        public string message;
    }  

    static CustomException createCustomException(String message) {
        System.Debug(message);
        CustomException ex = new CustomException(message);
        ex.setMessage(message);
        
        System.debug(ex);
        return ex;
        
    }
}