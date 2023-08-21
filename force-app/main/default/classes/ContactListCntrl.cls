public class ContactListCntrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        List<Contact> conlist = [SELECT id,LastName FROM Contact Limit 10];
        return conlist;
        
    }

}