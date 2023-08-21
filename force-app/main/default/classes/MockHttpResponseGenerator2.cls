@isTest
global class MockHttpResponseGenerator2 implements HttpCalloutMock {
    
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
           
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"items": [{"id": "6d2t20thtbdivg6fd909lcsce6","start": {"dateTime": "2022-07-11T13:30:00+05:30","timeZone": "Asia/Kolkata"},"end": {"dateTime": "2022-07-11T14:30:00+05:30","timeZone": "Asia/Kolkata"},"hangoutLink": "https://meet.google.com/soa-zygc-brq"}]}');
        res.setStatusCode(200);
        return res;
    }

}