public class createAcc {
    @AuraEnabled
    public static Account getAccrecords(Account acc){
        system.debug('acc'+acc);
        
        insert acc;
        return acc;
        
        
    }
    
    

}