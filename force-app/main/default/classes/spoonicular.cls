public class spoonicular {
    private static final string SPOONICULAR_API = 'https://api.spoonacular.com';
    private static final string API_KEY = '089ed43785e7419092f997f17dfe491a';
    public static void getspoonicularReceipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONICULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        
        system.debug('response code'+response.getStatusCode());
        if(response.getStatusCode() == 200) {
            system.debug('response'+response.getBody());
        }
        

    }
    
    
    public static void getReceipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONICULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        
        system.debug('response code'+response.getStatusCode());
        if(response.getStatusCode() == 200) {
            system.debug('response'+response.getBody());
        }
        

    }
    
    
    
    
    public static void getReceipeByIngredients(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONICULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        
        system.debug('response code'+response.getStatusCode());
        if(response.getStatusCode() == 200) {
            system.debug('response'+response.getBody());
        }
        

    }
    
    
    
    
}