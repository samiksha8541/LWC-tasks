public class Accountpopup 
{
    public Account a {get;set;}
    public string status {get;set;}
    public Accountpopup()
    {
        a = new account();  
    }
    public pagereference save()
    {
        ID caseID = apexpages.currentPage().getParameters().get('id');
        if(caseid!=null)
        {
            account acc = [select Name,Phone from account where ID =: caseID];
            acc.Name = a.Name;
            acc.Phone = a.Phone;
            update acc;
        }
        
        return null;
    }
    
    public pagereference cancel()
    {
        status = 'true';
        return null;    
    }
}