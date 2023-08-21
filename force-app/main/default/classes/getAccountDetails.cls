public class getAccountDetails {
    @AuraEnabled
    public static List<Account> getAccDetails(){
        List<Account> acclist = [Select id,Name,Industry From Account];
        return acclist;
        
    }
    
}