public class vfTaskController {
    public boolean renderStPage{get;set;}
    public List<College__c> clglist{get;set;}
    public List <student__c> studentsList {get;set;}
    public student__c addStu{get;set;}
    public String collegeId {get;set;}
    public boolean showData{get;set;}
    public string clgname{get;set;}
     public string stuname{get;set;}
    
    public boolean display{get; set;}
    
    public vfTaskController() {
        showData = false;
        addStu = new student__c();
        renderStPage = false;
        display = false;
        collegeId = '';
        clgname = '';
        stuname = '';
        clglist =  [SELECT Id,Name,Code__c,PhoneNum__c  FROM College__c];
        
    }
    Public PageReference GetRecordPage(){
        
        System.debug('collegeId : ' + collegeId);
        if(collegeId != null){
            //show dynamically clg name 1 way
            studentsList = [SELECT Id, Name,LastName__c,College__c,College__r.Name, Roll_No__c,Email__c  FROM Student__c where College__c =: collegeId];
            showData = true;
            //show dynamically clg name 1 way
           // College__c clg = [SELECT Id,Name,Code__c,PhoneNum__c  FROM College__c where id =: collegeId limit 1];
            //clgname = clg.Name;
            //show dynamically clg name 1 way
           // clgname = [SELECT Id,Name,Code__c,PhoneNum__c  FROM College__c where id =: collegeId limit 1].Name;
            
            clgname = studentsList[0].College__r.Name;
        }
        return null;   
    }
    
    public List <student__c> getStudentsList() {
        studentsList = [SELECT Id, Name,LastName__c,College__c, Roll_No__c,Email__c  FROM Student__c LIMIT 1];
        if(studentsList.size() > 0)
        {
            studentsList.addall(studentsList);        
        }    
        return studentsList;
    }
    
    
    public PageReference cancel() {
        return null;
    }
    
    public PageReference save() {
        system.debug('addStu name:' + addStu.name + ' = ' + addStu.Roll_No__c);
        upsert addStu;
        return null;
    }
    
    public void addStudent() {
        renderStPage = true;
        system.debug('stuname'+stuname);
        addStu.College__c = stuname;
        
    }
    
    
}