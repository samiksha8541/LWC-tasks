public class showStudentList {
    public List<student__c> stdlist{get;set;} 
    public boolean display{get; set;}
    
    public showStudentList(){
        display = false;
   
    }
    Public PageReference GetRecordPage(){
        
        display = true;
        showStudents();
        
        return null;   
    }
    Public List<student__c> showStudents(){
        stdlist =  new List<student__c>();
        List<student__c> listitem = [SELECT Id, Name,Roll_No__c,Email__c  FROM Student__c LIMIT 10];
        if(listitem.size() > 0)
        {
            stdlist.addall(listitem);        
        }    
        return stdlist;
    }
}