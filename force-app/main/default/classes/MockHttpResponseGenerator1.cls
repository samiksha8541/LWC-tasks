@isTest
global class MockHttpResponseGenerator1 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
           
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"snippet": "Dear Surinder Singh","payload": {"partId": "1","mimeType": "multipart/alternative","filename": '+
                                     '"test","headers": [{"name": "To","value": "<er.surindersingh.oaktree@gmail.com>","Subject": "Test Mail"}, '+
                                     '{"name": "Subject","value": "<er.surindersingh.oaktree@gmail.com>"},'
                                     +'{"name": "From","value": "<er.surindersingh.oaktree@gmail.com>"},'
                                     +'{"name": "From","value": "er.surindersingh.oaktree@gmail.com"},{"name": "To","value": "er.surindersingh.oaktree@gmail.com"}]}},{"content":"Test ","fromEmail":"er.surindersingh.oaktree@gmail.com","messageId":"1813a9877","ParentId":"1813a9871","Subject":"Test Mail","toEmail":"surindersingh.oaktree@gmail.com"}');
	    res.setStatusCode(200);          
        res.setStatusCode(200);
        return res;
       
    }
}