public with sharing class VFChallenge9Controller {
    public List<AccountWrapper> accountList { get; set; }
    public String searchTerm { get; set; }

    public VFChallenge9Controller() {
        searchTerm = '';
        accountList = new List<AccountWrapper>();
        fetchAccounts();
    }

    @RemoteAction
    public static List<AccountWrapper> fetchAccounts(String searchTerm) {
        String filter = (searchTerm != null && searchTerm != '') ? '%' + searchTerm + '%' : '%';

        List<Account> accounts = [
            SELECT Id, Name, (SELECT Name FROM Contacts) 
            FROM Account 
            WHERE Name LIKE :filter
        ];

        List<AccountWrapper> accountList = new List<AccountWrapper>();
        for (Account acc : accounts) {
            accountList.add(new AccountWrapper(acc));
        }
        return accountList;
    }

    public class AccountWrapper {
        public String accountName { get; set; }
        public String contactNames { get; set; }

        public AccountWrapper(Account acc) {
            this.accountName = acc.Name;

            if (acc.Contacts != null && !acc.Contacts.isEmpty()) {
                List<String> contactList = new List<String>();
                for (Contact con : acc.Contacts) {
                    contactList.add(con.Name);
                }
                this.contactNames = String.join(contactList, ', ');
            } else {
                this.contactNames = 'No Contacts';
            }
        }
    }
}
