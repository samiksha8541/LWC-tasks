public class spinnerController {
    public static Boolean checkbox {get;set;}
    public spinnerController(){
        checkbox = false;
        system.debug('======');
    }
    public static PageReference buttonclick(){
       list<Account> demolist = new list<Account>();
      list<Account> acclist = [SELECT id,Name,Rating FROM Account];
         list<Contact> contlist = [SELECT id,Name FROM Contact];
        for(Account acc :acclist){
            if(acc.rating == 'Hot'){
                demolist.add(acc);
            }
          
        }
      for(Account acc :acclist){
            if(acc.rating == 'Hot'){
                demolist.add(acc);
            }
          
        }
        for(Account acc :acclist){
            if(acc.rating == 'Hot'){
                demolist.add(acc);
            }
          
        }
        for(Contact con :contlist){
            System.debug('=====con===');
          
        }
        for(Contact con :contlist){
            System.debug('=====con==='+con.Name);
            con.email = 'test@gmail.com';
          
        }
        update contlist;
      checkbox = true;
        return null;
    }
    
  
}