public class addContactController {
    public Contact con {get;set;}
    public addContactController(){
        con = new Contact();
    }
    public void saveContact(){
        insert con;
        con = new Contact();
        
    }

}