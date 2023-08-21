global class StripeAPI {
    
    global static string ApiKey{
        get{
        
            
            Stripe_Setting__c s = Stripe_Setting__c.getInstance();
            if(s != null){
                return s.Stripe_Secret_Test_Key__c;
            
            }
            return null;   
            
        }
    }
        
    global static string publishableKey{
        get{
       
              Stripe_Setting__c s = Stripe_Setting__c.getInstance();
            if(s != null){
                     return s.Stripe_Publishable_Test_Key__c;
            }
            return null;
        }
            
            
            
        }
       
        
    }