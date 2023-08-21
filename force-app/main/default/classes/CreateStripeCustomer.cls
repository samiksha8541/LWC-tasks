public class CreateStripeCustomer {
    private static final String CUSTOMER_URL = 'https://api.stripe.com/v1/customers';
    private static final String API_KEY = 'sk_test_51MqybuSHyOM3LbQAPEdoc9Ct0ceK0xAoKWhSKnoH8M9jOvPe03Q0e0dW9zoFbAMFoz0EdbBpLQ8ZMlQm9hoTFUGt00DM2vjWuX';

    public static String createStripeCustomer(Contact contact) {
        String email = contact.Email;
        String name = contact.FirstName + ' ' + contact.LastName;
        
        if (email == null || name == null) {
            return null;
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(CUSTOMER_URL);
        system.debug('CUSTOMER_URL'+ CUSTOMER_URL);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + API_KEY);
        system.debug('API_KEY'+ API_KEY);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody('email=' + EncodingUtil.urlEncode(email, 'UTF-8') + '&name=' + EncodingUtil.urlEncode(name, 'UTF-8'));
        Http http = new Http();
        
        try {
            HttpResponse res = http.send(req);
            System.debug('Response status code: ' + res.getStatusCode());
            System.debug('Response body: ' + res.getBody());
            
            if (res.getStatusCode() == 200) {
                StripeCustomerResponse response = (StripeCustomerResponse) JSON.deserialize(res.getBody(), StripeCustomerResponse.class);
                return response.id;
            }
        } catch (System.CalloutException e) {
            System.debug('Callout error: ' + e.getMessage());
        }
        
        return null;
    }

    public class StripeCustomerResponse {
        public String id;
    }
}