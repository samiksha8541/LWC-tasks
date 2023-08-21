public with sharing class StudentController {
    public string source {get;set;}
    public List<selectOption> sourceValue {get;set;}
    public boolean flag {get;set;}
    public boolean flag1 {get;set;}
    public boolean flag2 {get;set;}
    public 	Student__c stu1{get;set;}
    public Teacher__c tch1{get;set;}
    
    
    public StudentController()
    {
        flag = false;
        flag1 = false;
        flag2 = false;
        stu1 = new Student__c();
        //tch1 = new Teacher__c();
        sourceValue = new List<selectOption>();
        sourceValue.add(new selectOption('','--select--'));
        sourceValue.add(new selectOption('AddStudents','AddStudents'));
        //sourceValue.add(new selectOption('Teacher','Teacher'));
    }
    
    public void objectDisplay()
    { 
         If(source == 'AddStudents'){
            flag = true;
            flag2= true;
            flag1 = false;
        }
       /* else if(source == 'Teacher'){
            flag1 = true;
            flag2= true;
            flag = false;
        }*/
    }
    public void saveRecord() {
        if(source=='AddStudents') {
        insert stu1;
ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,' Record Created Successfully.Thank you!'));
        stu1 = new Student__c();
        }
        else {
            insert tch1;
ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,' Record Created Successfully.Thank you!'));
            tch1 = new Teacher__c();
        }
    }
    public void clearFunction(){
        if(source=='AddStudents') {
        stu1 = new Student__c();
        }
        else{
        tch1 = new Teacher__c();
        }
    }
}