public class StripeCallouts {
    private static final string Customer_URL = 'https://api.stripe.com/v1/customers';
    private static final string API_KEY = StripeAPI.ApiKey;
    //private static final string PUBLISHABLE_KEY = StripeAPI.publishableKey();
    public static HttpResponse makeGetCallout(){
        system.debug('API_KEY'+API_KEY);
        Integer statusCode;
        string response;
        HttpRequest http = new HttpRequest();
        http.setEndpoint(CUSTOMER_URL);
        http.setMethod('POST');
       Blob headerValue = Blob.valueOf(API_KEY + ':');
       String authorizationHeader = 'Basic '+ EncodingUtil.base64Encode(headerValue);
        system.debug('authorizationHeader'+authorizationHeader);
        http.setHeader('Authorization',authorizationHeader);
        Http con = new Http();
        HttpResponse hs = con.send(http);
        system.debug('#######'+hs.getBody());
        response = hs.getBody();
        statusCode = hs.getStatusCode();
        system.debug('##statuscode'+hs.getStatusCode());
        return hs;
        
        
    }
    
    
    
    
    

}