public class RecordDeleteEmail {
    
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}
    @InvocableMethod(label='Prevent EmailMessage Deletion' description='EmailMessage Deletion')
    public static void getMessage(){
        System.debug('checking 7');
        try {
            throw new OtherException('Error Parsing: We Can not Delete Email Messages Record');
        } catch(BaseException   ex) {
            System.debug(ex.getMessage());
        }
    }
}