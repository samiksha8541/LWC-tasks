public with sharing class contactList {

    public contactList(ApexPages.StandardSetController controller) {

    }
   public List<Lead> getContactList(){
    List<Lead>  c = [select id, Name  from  Lead Limit 10];
   return c;
   
   
    }
}