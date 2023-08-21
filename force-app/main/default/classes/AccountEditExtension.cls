public class AccountEditExtension {
    public Account account { get; private set; }
    public Date startDate { get; set; }
    public Date endDate { get; set; }
    public String accountName { get; set; }

    public AccountEditExtension(ApexPages.StandardController controller) {
        String accountId = ApexPages.currentPage().getParameters().get('accountId');
        if (accountId != null) {
            account = [SELECT Start_Date__c, End_Date__c, Name FROM Account WHERE Id = :accountId];
            startDate = account.Start_Date__c;
            endDate = account.End_Date__c;
            accountName = account.Name;
        }
    }

    public PageReference saveAccount() {
        try {
            account.Start_Date__c = startDate;
            account.End_Date__c = endDate;
            account.Name = accountName;
            update account;
            PageReference accountDetailPage = new PageReference('/' + account.Id);
            accountDetailPage.setRedirect(true);
            return accountDetailPage;
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An error occurred while saving the account.'));
            return null;
        }
    }
}