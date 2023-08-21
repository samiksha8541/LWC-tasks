@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
           
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        if(req.getEndpoint() == 'https://www.googleapis.com/gmail/v1/users/er.surindersingh.oaktree@gmail.com/messages?maxResults=1'){
        	res.setBody('{"messages":[{"id": "1813a9877", "threadId": "1813a98771f89dd5"}], "messages":[{"id": "1813a9887", "threadId": "1813a98771f89id5"}]}');
        }else{
            res.setBody('{"messages":[{"id": "1813a9877", "threadId": "1813a98771f89dd5"}]}'); 
        }
        
        /*if(req.getEndpoint() == 'https://www.googleapis.com/gmail/v1/users/er.surindersingh.oaktree@gmail.com/messages/1813a98771f89dd5'){
             res.setBody('{"snippet": "Dear Surinder Singh","payload": {"partId": "1","mimeType": "multipart/alternative","filename": '+
                       '"test","headers": [{"name": "To","value": "er.surindersingh.oaktree@gmail.com"}]}}'); 
        }else{
             res.setBody('{"payloadMap"{body:{size:0}, "filename":,'+
                         '"headers":({"name":"Delivered-To", "value":"er.surindersingh.oaktree@gmail.com"},'+
                         '{"name":"Received","value":"by 2002:a17:902:db0d:b0:167:667c:edd5with SMTP id m13csp1702045plx;Mon,6 Jun 2022 12:57:59-0700(PDT)"},'+
                         '{"name":"X-Google-Smtp-Source", "value":"ABdhPJxbhYR3U/E0ir1SMnkhTYgXMoU+cLh8tYQ5Iyqe4n4BO+t3Dz5vVP16KuVQExt0HEK93mOf"})}'); 
        }*/
              
       // if(req.getEndpoint() == 'https://www.googleapis.com/gmail/v1/users/er.surindersingh.oaktree@gmail.com/messages/1813a98771f89dd5'){}
         
        res.setStatusCode(200);
        return res;
       
    }
}