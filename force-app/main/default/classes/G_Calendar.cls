public class G_Calendar /*implements Schedulable*/ {
    
    private static final Integer BATCH_FREQUENCY_IN_MINUTES = 1; // ideally it should goto custom settings.
    private static final String JOB_NAME = 'GoogleCalendar';
    
    public static String cred, mail, contId, sDateTime, eTime, meetLink;
    public static String [] sDate, endTime;
    public static DateTime startDateTimeConvert, endDateTimeConvert;
    public static Object eventId, startdatetime, enddatetime, GmeetLink, zoomLink, subject;
    
    public static Set<String> ids = new Set<String>();
    public static Set<String> mails = new Set<String>();
    public static Set<Event> myevents = new Set<Event>();
    public static Map<String, String> contIdMap = new Map<String, String>();
    public static Map<String,Object> data = new Map<String, Object>();
    
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    /*public void execute(SchedulableContext sc){
rescheduleJob(JOB_NAME, BATCH_FREQUENCY_IN_MINUTES);
getCalendarEvent();
}*/
    
    // @future (callout=true)
    public static void getCalendarEvent(){
        try{
            Map<String, Named_Credential__mdt> named_cred = Named_Credential__mdt.getAll();
            for(String ncred : named_cred.keySet()){
                cred = named_cred.get(ncred).NamedCredential__c;
                mail = named_cred.get(ncred).Mail_Id__c;
                mails.add(mail);
                
                request = new HttpRequest();
                request.setMethod('GET');
                
                //String timestampMax = String.valueOf(datetime.now().formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''));
                //String timestampMin = String.valueOf(datetime.now().addDays(-2).formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''));
                
                request.setEndpoint('callout:'
                                    + cred
                                    +'/calendar/v3/calendars/'
                                    + mail
                                    + '/events');
                //?timeMin='+timestampMin+'&timeMax='+timestampMax
                
                response = http.send(request);
                System.debug('results'+response.getBody());
                
                response = http.send(request);
                if(response.getStatusCode() == 200){
                    System.debug('results'+response.getBody());
                    Map<String, Object> results = new Map<String, Object>();
                    results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                    List<Object> objlst = (List<Object>)results.get('items');
                    System.debug('objlst: ' + objlst);
                    
                    if(!objlst.isEmpty() && objlst.size() > 0){
                        for(Object obj : objlst){
                            data = (Map<String,Object>)obj;
                        }// for objlst  
                        
                        //Reterving the required values 
                        startdatetime = (Object)data.get('start');
                        enddatetime = (Object)data.get('end');
                        GmeetLink = (Object)data.get('hangoutLink');
                        eventId = (Object)data.get('id');
                        zoomLink = (Object)data.get('location');
                        subject = (Object)data.get('summary');
                        
                        if(startdatetime != null && startdatetime != ''){
                            if(String.valueOf(startdatetime).contains('Z')){
                                sDateTime = String.valueOf(startdatetime).subStringBetween('=', 'Z');
                                sDate = sDateTime.split('T');
                                System.debug('sDate:' + sDate);
                            }else{
                                sDateTime = String.valueOf(startdatetime).subStringBetween('=', '+');
                                System.debug('sDateTime: '+ sDateTime);
                                sDate = sDateTime.split('T');
                                System.debug('sDate:' + sDate);
                            } 
                        }else{
                            startdatetime = String.valueOf(System.now());
                            System.debug('startdatetime:' + startdatetime);
                            sDate = String.valueOf(startdatetime).split(' ');
                            System.debug('sDate:' + sDate);
                        }
                        
                        if(enddatetime != null && enddatetime != ''){
                            if(String.valueOf(enddatetime).contains('Z')){
                                eTime = String.valueOf(enddatetime).subStringBetween('=', 'Z');
                                endTime = eTime.split('T');
                            }else{
                                eTime = String.valueOf(enddatetime).subStringBetween('=', '+');
                                endTime = eTime.split('T');
                            }
                        }else{
                            enddatetime = String.valueOf(System.now());
                            endTime = String.valueOf(enddatetime).split(' ');
                        }
                        
                        //DateTime for Event Object
                        String sd = sDate[0] + ' ' + sDate[1] + ' ' + '+0530';
                        startDateTimeConvert = DateTime.valueOf(sd);
                        String ed = endTime[0] + ' ' + endTime[1] + ' ' + '+0530';
                        endDateTimeConvert = DateTime.valueOf(ed);
                        
                        if(String.valueOf(zoomLink) != null)
                            meetLink = String.valueOf(zoomLink);
                        else
                            meetLink = String.valueOf(GmeetLink);
                        
                        
                    }//obj !null
                }//if getStatusCode
            }//named cred 
            System.debug('===test===='+mail);
            List<Contact> contSearchList = [SELECT Id, Email FROM Contact WHERE Email IN: mails];
            
            List<User> userList = [SELECT Id FROM User WHERE Email IN : mails];
            System.debug('userList: ' + userList);
            System.debug('contSearchList: ' + contSearchList);
            
            if(contSearchList.size() > 0 && contSearchList != null && !contSearchList.isEmpty()){
                for(Contact cnt : contSearchList){
                    if(!contIdMap.containsKey(cnt.Email)){
                        contIdMap.put(cnt.Email, cnt.Id); 
                        System.debug('1contIdMap' + contIdMap);
                    }else{
                        //contIdMap.get(cnt.Email).put(cnt.Email, cnt.Id);
                    }
                }
            }
            
            System.debug('3contIdMap' + contIdMap);
            
            for(String m : mails){
                for(String s : contIdMap.keySet()){
                    if(s.equals(m)){
                        myevents.add(new Event(
                            WhoId = contIdMap.get(s),
                            //Email_Id__c = mail,
                            Event_Id__c = String.valueOf(eventId),
                            StartDateTime = startDateTimeConvert,
                            EndDateTime = endDateTimeConvert,
                            Location = meetLink,
                            Description = String.valueOf(subject),
                            Subject = 'Meeting'  
                        ));
                    }
                }
            }
            
            List<Event> myeventsList = new List<Event>(myevents);
            System.debug('===before ===='+myevents);
            Schema.SObjectField f1 = Event.Fields.Event_Id__c; 
            Database.upsert(myeventsList, f1); 
            System.debug('==myevents==='+myevents);
            
        }catch(Exception e){
            Exception_ErrorLog__c error = new Exception_ErrorLog__c();
            error.Class__c = 'G_Calendar';
            //error.Method__c = 'getCalendarEvent()';
            //error.Id_and_Email__c = String.valueOf(eventId);
            error.Error_Message__c = e + ' Line Number: '+e.getLineNumber();
            insert error;
        }//end of catch()
    }//end of getCalendarEvent()
    
    public static void rescheduleJob(String jobName, Integer batchFrequencyMinutes) {
        System.debug('GoogleCalendar.rescheduleJob : jobName ' + jobName + ' batchFrequencyMinutes ' + batchFrequencyMinutes );
        abortJobByName(jobName);
        Datetime dt = system.now().addMinutes(batchFrequencyMinutes);
        String cronExpression = '0 ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + ' ' + dt.year();
        System.debug('GoogleCalendar.rescheduleJob : cronExpression ' + cronExpression );
        //System.schedule(jobName, cronExpression, new G_Calendar());
    }
    
    public static void abortJobByName(String jobName) {
        System.debug('GoogleCalendar.abortJobByName : jobName ' + jobName );
        List<CronTrigger> cronTriggers = [select id, TimesTriggered, NextFireTime, CronExpression, PreviousFireTime, StartTime, EndTime 
                                          from CronTrigger WHERE CronJobDetail.Name = 'GoogleCalendar'];
        for(CronTrigger cronTrigger : cronTriggers ) {
            abortJobById(cronTrigger.Id);
        }
    }
    
    public static void abortJobById(String jobId) {
        System.debug('GoogleCalendar.abortJobById : jobId ' + jobId );
        System.abortJob(jobId);
    }
    
}//end of G_Calendar class