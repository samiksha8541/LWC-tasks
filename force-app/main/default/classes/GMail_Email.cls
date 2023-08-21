public class GMail_Email implements Schedulable{
    
    private static final Integer BATCH_FREQUENCY_IN_MINUTES = 1; // ideally it should goto custom settings.
    private static final String JOB_NAME = 'GMail_Email';
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    public void execute(SchedulableContext sc){
        
        rescheduleJob( JOB_NAME, BATCH_FREQUENCY_IN_MINUTES );
        No_of_Messages__c msgLimit = [SELECT Msgs_Limit__c FROM No_of_Messages__c LIMIT 1];
        getMessageIds((Integer)msgLimit.Msgs_Limit__c);
        
    }
    
    @future (callout=true)
    public static void getMessageIds(integer i){
        String idemail = '';
        try{
            String cred, mail;
            Map<String, Named_Credential__mdt> named_cred = Named_Credential__mdt.getAll();
            for(String ncred : named_cred.keySet()){
                cred = named_cred.get(ncred).NamedCredential__c;
                mail = named_cred.get(ncred).Mail_Id__c;
            }
            
            Map<String,GoogleEmailWrap> mapOfemailWrap = new Map<String,GoogleEmailWrap>();
            Set<String> ids = new Set<String>();
            request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint('callout:'
                                + cred
                                +'/gmail/v1/users/'
                                + mail
                                + '/messages?maxResults='+i);
            //request.setEndpoint('callout:GMail_API/gmail/v1/users/uma@oaktreecloud.com/messages?maxResults='+i);
            response = http.send(request); 
            System.debug(response.getBody());
            
            Map<String, Object> results = new Map<String, Object>();
            results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> objlst = (List<Object>)results.get('messages');
            
            for(Object o : objlst){
                Map<String, Object>  idmap = (Map<String, Object>)o;
                ids.add(String.valueOf(idmap.get('id')));
            }
            System.debug('==='+ids);
            List<String> emaillst = new List<String>();
            //Set<String> emailset = new Set<String>();
            Map<String,String> mapOfEmail = new Map<String,String>();
            //Map<String,GoogleEmailWrap> mapOfEmailDetail = new Map<String,GoogleEmailWrap>();
            List<EmailMessage> emailMessagelst = new List<EmailMessage>();
            //List<EmailMessage> emailMsglst = new List<EmailMessage>();
            
            for(String s: ids){
                GoogleEmailWrap wrap = new GoogleEmailWrap();
                EmailMessage em = new EmailMessage();
                request = new HttpRequest();
                request.setMethod('GET');
                
                request.setEndpoint('callout:'
                                    + cred
                                    + '/gmail/v1/users/'
                                    + mail
                                    + '/messages/'+s);
                //request.setEndpoint('callout:GMail_API/gmail/v1/users/uma@oaktreecloud.com/messages/'+s);
                
                if(!Test.isRunningTest()){   
                    response = http.send(request); 
                }
                else{
                    response.setBody('{"snippet": "Dear Surinder Singh","payload": {"partId": "1","mimeType": "multipart/alternative","filename": '+
                                     '"test","headers": [{"name": "To","value": "<er.surindersingh.oaktree@gmail.com>","Subject": "Test Mail"}, '+
                                     '{"name": "Subject","value": "<er.surindersingh.oaktree@gmail.com>"},'
                                     +'{"name": "From","value": "<er.surindersingh.oaktree@gmail.com>"},'
                                     +'{"name": "From","value": "er.surindersingh.oaktree@gmail.com"},{"name": "To","value": "er.surindersingh.oaktree@gmail.com"}]}},{"content":"Test ","fromEmail":"er.surindersingh.oaktree@gmail.com","messageId":"1813a9877","ParentId":"1813a9871","Subject":"Test Mail","toEmail":"surindersingh.oaktree@gmail.com"}');
                    response.setStatusCode(200);                
                }
                System.debug('res========'+response.getBody());
                results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                Map<String, Object> payloadMap = (Map<String, Object>)results.get('payload');
                List<Object> headerlst = (List<Object>)payloadMap.get('headers');
                
                for(Object o : headerlst){
                    Map<String,Object> valueMap = (Map<String,Object>)o;
                    
                    if(String.valueOf(valueMap.get('name')) == 'To'){
                        emaillst.add(String.valueOf(valueMap.get('value')));
                        String str = String.valueOf(valueMap.get('value'));
                        if(str.contains('<') && str.contains('>')){
                            wrap.toEmail = str.substringBetween('<', '>');
                            mapOfEmail.put(s,wrap.toEmail);
                            em.ToAddress  = str.substringBetween('<', '>');
                        }else{
                            wrap.toEmail = str;
                            mapOfEmail.put(s,wrap.toEmail);
                            em.ToAddress = str;
                        }
                        wrap.messageId = s;
                        wrap.content = String.valueOf(results.get('snippet'));
                        em.Message_Id__c = s;
                        idemail = s + ' '+em.ToAddress;
                        em.TextBody = String.valueOf(results.get('snippet'));
                    }
                    if(String.valueOf(valueMap.get('name')) == 'Subject'){
                        wrap.subject = String.valueOf(valueMap.get('value')); 
                        em.Subject = String.valueOf(valueMap.get('value')); 
                    }
                    
                    if(String.valueOf(valueMap.get('name')) == 'From'){
                        String str = String.valueOf(valueMap.get('value')); 
                        if(str.contains('<') && str.contains('>')){
                            wrap.fromEmail = str.substringBetween('<', '>');
                            em.FromAddress = str.substringBetween('<', '>');
                        }else{
                            wrap.fromEmail = str;
                            em.FromAddress = str;
                        }
                    }
                }
                mapOfemailWrap.put(s,wrap);
                em.Is_Available__c = false;
                em.Is_From_Gmail__c = true;
                emailMessagelst.add(em);
            }
            
            String emails = '';
            for(String sId : ids){
                String s = mapOfEmail.get(sId); 
                if(s != null && s != ''){
                    if(s.contains(',')){
                        List<String> lst = s.split(',');
                        for(String e : lst){
                            if(emails == ''){
                                emails = e;
                            }else{
                                emails += ' OR '+e; 
                            }  
                        }
                    }else{
                        if(emails == ''){
                            emails = s;
                        }else{
                            emails += ' OR '+s; 
                        }
                    }
                } 
            }
            System.debug('==emails==='+emails);
            List<List<sObject>> searchList = [FIND :emails IN EMAIL FIELDS RETURNING Contact(Id, Email),Lead(Id, Email)];
            List<Email__c> elst = new List<Email__c>();
            List<Email_Detail__c> emailDetail = new List<Email_Detail__c>();
            System.debug('===searchList=='+searchList);
            System.debug('====size=='+searchList.size());
            if(searchList.isEmpty()){
                System.debug('====SearchList.isEmpty()=======');
                /* for(String sId : ids){
String s = mapOfEmail.get(sId); 
if(s != null && s != ''){
Email__c e = new Email__c();
e.email__c = s;
elst.add(e);
}
}*/
            }else{
                Set<Integer> rmvSet = new Set<Integer>();
                
                System.debug('====earchList.isEmpty()====else=====');
                List<Contact> searchContacts = ( List<Contact>)searchList[0];
                List<Lead> searchLeads = ( List<Lead>)searchList[1];
                String contId, leadId;
                Set<String> ldemails = new Set<String>();
                if(!searchContacts.isEmpty()){
                    for (Contact c : searchContacts) {
                        contId = c.Id;
                        /*for(String sId : ids){
String s = mapOfEmail.get(sId); 
if(s != null && s != ''){
if(c.Email == s){
}else{
for (Lead l : searchLeads) {
if(l.Email == s){
}else{
ldemails.add(s); 
}
} 
}
}
}*/
                        Integer index = 0;
                        for(EmailMessage emsg : emailMessagelst){
                            if(c.Email == emsg.ToAddress){
                                // rmvSet.add(index);
                                emsg.Is_Available__c = true;
                                emsg.Contact__c = contId;
                            }else{
                                for (Lead l : searchLeads) {
                                    leadId = l.Id;
                                    if(l.Email == emsg.ToAddress){
                                        //rmvSet.add(index);
                                        emsg.Is_Available__c = true;
                                        emsg.Lead__c = leadId;
                                    }
                                }
                            }
                            index++;
                        }
                    }
                }else if(!searchLeads.isEmpty()){
                    for (Lead l : searchLeads) {
                        /*for(String sId : ids){
String s = mapOfEmail.get(sId); 
if(s != null && s != ''){
if(l.Email == s){
}else{
ldemails.add(s);   
}
}
}*/
                        Integer index = 0;
                        for(EmailMessage emsg : emailMessagelst){
                            if(l.Email == emsg.ToAddress){
                                //rmvSet.add(index); 
                                emsg.Is_Available__c = true;
                                emsg.Lead__c = leadId;
                            }
                            index++;
                        }
                    }
                }/* else{
for(String sId : ids){
String s = mapOfEmail.get(sId); 
if(s != null && s != ''){
Email__c e = new Email__c();
e.email__c = s;
elst.add(e);
}
}
}
for(String s : ldemails){
System.debug('=ldemails==s==='+s);
Email__c e = new Email__c();
e.email__c = s;
elst.add(e);
}*/
                //insert elst;
                System.debug('===emailMessagelst==='+emailMessagelst);
                System.debug('==size==='+emailMessagelst.size());
                //System.debug('===rmvSet==='+rmvSet);
                /*for(Integer idx : rmvSet){
//emailMessagelst.remove(idx);
} */
            }
            Schema.SObjectField m = EmailMessage.Fields.Message_Id__c;
            Database.upsert(emailMessagelst,m);
            System.debug('==elst=='+elst);
            
            Schema.SObjectField f = Email__c.Fields.email__c;
            Database.upsert(elst,f);
            
            /* List<Email_Detail__c> lstEmailDetails = new List<Email_Detail__c>();

for(Email__c e : elst){
for(String sId : ids){
String s = mapOfEmail.get(sId);
GoogleEmailWrap emailWrapRecord = mapOfemailWrap.get(sId);
if(s != null && s != '' && s == e.email__c){
System.debug('==emailWrapRecord=='+emailWrapRecord);
Email_Detail__c eD = new Email_Detail__c();
eD.From_Email__c = emailWrapRecord.fromEmail;
//eD.To_Email__c = emailWrapRecord.toEmail;
eD.Subject__c = emailWrapRecord.subject;
eD.Message_Id__c = emailWrapRecord.messageId;
eD.Content__c = emailWrapRecord.content;
eD.Email__c = e.id;
lstEmailDetails.add(eD);
}
}
}

Schema.SObjectField f1 = Email_Detail__c.Fields.Message_Id__c;
Database.upsert(lstEmailDetails,f1);*/
            
        }
        catch(Exception e){
            /*Exception_ErrorLog__c error = new Exception_ErrorLog__c();
error.Class__c = 'GMail_Email';
error.Method__c = 'getMessageIds()';
error.Id_and_Email__c = idemail;
error.Error_Message__c = e + ' Line Number: '+e.getLineNumber();
insert error;*/
            
        }
    }
    public static void rescheduleJob(String jobName, Integer batchFrequencyMinutes) {
        System.debug('GMail_Email.rescheduleJob : jobName ' + jobName + ' batchFrequencyMinutes ' + batchFrequencyMinutes );
        abortJobByName(jobName);
        Datetime dt = system.now().addMinutes(batchFrequencyMinutes);
        String cronExpression = '0 ' + dt.minute() + ' ' + dt.hour() + ' ' + dt.day() + ' ' + dt.month() + ' ? ' + ' ' + dt.year();
        System.debug('GMail_Email.rescheduleJob : cronExpression ' + cronExpression );
        System.schedule(jobName, cronExpression, new GMail_Email());
    }
    
    public static void abortJobByName(String jobName) {
        System.debug('GMail_Email.abortJobByName : jobName ' + jobName );
        List<CronTrigger> cronTriggers = [select id, TimesTriggered, NextFireTime, CronExpression, PreviousFireTime, StartTime, EndTime 
                                          from CronTrigger WHERE CronJobDetail.Name = 'GMail_Email'];
        for(CronTrigger cronTrigger : cronTriggers ) {
            abortJobById(cronTrigger.Id);
        }
    }
    
    public static void abortJobById(String jobId) {
        System.debug('GMail_Email.abortJobById : jobId ' + jobId );
        System.abortJob(jobId);
    }
    public class GoogleEmailWrap{
        public String toEmail = '';
        public String fromEmail = '';
        public String content = '';
        public String subject = '';
        public String ParentId = '';
        public String messageId = '';
    }
    
}