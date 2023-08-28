public class AccountDetailExtension {
    public Account account { get; private set; }
    public Date startDate { get; private set; }
    public Date endDate { get; private set; }
    public String accountName { get; private set; }

    public AccountDetailExtension(ApexPages.StandardController controller) {
        String accountId = ApexPages.currentPage().getParameters().get('accountId');
        if (accountId != null) {
            account = [SELECT Start_Date__c, End_Date__c, Name FROM Account WHERE Id = :accountId];
            startDate = account.Start_Date__c;
            endDate = account.End_Date__c;
            accountName = account.Name;    
        }
    }
}