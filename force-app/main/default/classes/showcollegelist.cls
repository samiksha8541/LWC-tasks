public class showcollegelist {
   public List<College__c> clglist{get;set;} 
    public boolean display{get; set;}
    
    public showcollegelist(){
        display = false;
   
    }
    Public PageReference GetRecordPage(){
        
        display = true;
        showclg();
        
        return null;   
    }
    Public List<College__c> showclg(){
        clglist =  new List<College__c>();
        List<College__c> listitem = [SELECT Id,Name,Roll_No__c,PhoneNum__c  FROM College__c];
        if(listitem.size() > 0)
        {
            clglist.addall(listitem);        
        }    
        return listitem;
    }
}