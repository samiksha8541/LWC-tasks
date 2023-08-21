public class PaginationController {
  public List<Account> accounts { get; set; }

  public PaginationController() {
    accounts = new List<Account>();
  }

  @RemoteAction
  public static List<Account> getAccounts(Integer currentPage, Integer recordsPerPage) {
    Integer offset = (currentPage - 1) * recordsPerPage;
    List<Account> accountList = [SELECT Id, Name FROM Account ORDER BY Name];
    return accountList;
  }
}