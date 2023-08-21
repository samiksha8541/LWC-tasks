@isTest
public class GoogleEmailSch_Test {
   	
    public static testmethod void mailTest(){
        
       List<Contact> cont = new List<Contact>();
        cont.add(new Contact(
        	FirstName = 'Test',
        	LastName = 'Contact',
        	Email = 'surindersingh.oaktree@gmail.com'));
        insert cont;
        
        List<Lead> ld = new List<Lead>();
        ld.add(new Lead(
        	FirstName = 'Test',
        	LastName = 'Lead',
            Company = 'Test Company',
        	Email = 'surindersingh.oaktree@gmail.com'));
        insert ld;
        
        No_of_Messages__c msg = new No_of_Messages__c();
        msg.Msgs_Limit__c = 10;
        insert msg;
         Map<String, Named_Credential__mdt> named_cred = Named_Credential__mdt.getAll();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator1());
        GMail_Email gmail = new GMail_Email();
        System.schedule('GMail_Email', '0 22 * * * ?', gmail);
        GMail_Email.getMessageIds((Integer)msg.Msgs_Limit__c);
        Test.stopTest();
    }    
}