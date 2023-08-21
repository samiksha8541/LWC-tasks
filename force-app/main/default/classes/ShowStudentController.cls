public class ShowStudentController { 
    public Integer age {get;set;}
    public String Name{get;set;} 
    public Integer Rollno{get;set;}
    public String Email{get;set;} 
    public Boolean visibleSubmit { get; set; }
    public  List<Student__c> slist {get;set;}
    public  List<Student__c> getStudentList(){
        slist =  new List<student__c>();
        List<student__c> listitem = [SELECT Id, Name,Roll_No__c,Email__c  FROM Student__c];
        
        if(listitem.size() > 0)
        {
            slist.addall(listitem);        
        }    
        return slist;
    }
}