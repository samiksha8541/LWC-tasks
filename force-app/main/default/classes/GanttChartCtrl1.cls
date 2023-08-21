public class GanttChartCtrl1 {
	public List<String> Name{get;set;}
    public List<String> SDate{get;set;}
    public List<String> EDate{get;set;}
    public List<Integer> Duration{get;set;}
    public List<String> tStatus{get;set;}
    
    public GanttChartCtrl1(){
        List<Task> taskList = new List<Task>();
        Name = new List<String>();
        SDate = new List<String>();
        EDate = new List<String>();
        Duration = new List<Integer>();
        tStatus=new List<String>();
        
        Integer dd;
        Integer month;
        Integer year;
        
        String whatId= ApexPages.currentPage().getParameters().get('id');
        taskList = [SELECT Id, Subject, CreatedDate, ActivityDate, Status  FROM Task WHERE WhatId=:whatId];     
        for(Task ts:taskList){
            tStatus.add(ts.Status);
            Date todayDate = System.Date.today();
            dd = todayDate.day();
            month=todayDate.month();
            year = todayDate.year();
            Name.add(ts.Subject);
            SDate.add(year+'-'+month+'-'+dd);
            dd = ts.ActivityDate.day();
            month=ts.ActivityDate.month();
            year = ts.ActivityDate.year();
            EDate.add(year+'-'+month+'-'+dd);
            Integer dt = (system.today()).daysBetween(Date.valueOf(ts.ActivityDate));
            Duration.add(dt);
        }
    }
}