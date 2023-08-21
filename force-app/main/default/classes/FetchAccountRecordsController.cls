public class FetchAccountRecordsController {
    public List<Account> accountList { get; set; }
    public Date startDate { get; set; }
    public Date endDate { get; set; }
    public String selectedAccountId { get; set; }
    
    public FetchAccountRecordsController() {
        accountList = new List<Account>();
    }
    
    public void fetchAccounts() {
        if (startDate != null && endDate != null) {
            accountList = [
                SELECT Id, Name, Start_Date__c, End_Date__c
                FROM Account
                WHERE Start_Date__c >= :startDate
                AND End_Date__c <= :endDate
            ];
        }
    }
    
    public PageReference redirectToAccountDetail() {
        if (selectedAccountId != null) {
            PageReference accountDetailPage = new PageReference('/apex/AccountDetailPage');
            accountDetailPage.getParameters().put('accountId', selectedAccountId);
            return accountDetailPage;
        }
        return null;
    }
    
    
    public PageReference redirectToEditAccountDetail() {
        if (selectedAccountId != null) {
            PageReference AccountEditPage = new PageReference('/apex/AccountEditPage');
            AccountEditPage.getParameters().put('accountId', selectedAccountId);
            return AccountEditPage;
        }
        return null;
    }
    
    
}