public class totalContactsHandler {
    
    public static void countContacts(List<Contact> newlist ,List<Contact> oldlist){
        
        set<id> accuntids = new set<id>(); 
        
        if(newlist != null){
            
            for(Contact c : newlist){
            if(c.accountid != null){
                accuntids.add(c.accountid);
            }
            
        }
            
        }
        
        if(oldlist != null){
           for(Contact c : oldlist){
            if(c.accountid != null){
                accuntids.add(c.accountid);
            }
            
        }  
            
        }
        
        List<Account> accounts = [SELECT id,Total_Contacts__c,(SELECT id from Contacts)FROM Account where id in :accuntids];
        if(!accounts.isEmpty()){
            for(Account acc : accounts){
                acc.Total_Contacts__c = acc.contacts.size();
            }
            
        }
        update accounts;
        
        
    }
    

}