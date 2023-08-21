@isTest
public class G_CalTest {
    
    public static testmethod void mailTest(){
        
        List<Contact> cont = new List<Contact>();
        cont.add(new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'er.surindersingh.oaktree@gmail.com'));
        insert cont;
        
        Map<String, Named_Credential__mdt> named_cred = Named_Credential__mdt.getAll();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator2());
        G_Calendar gcal = new G_Calendar();
        System.schedule('GmailSch', '0 22 * * * ?', gcal);
        G_Calendar.getCalendarEvent();
        Test.stopTest();
    }
    
    
}