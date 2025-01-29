public with sharing class AccountSearchController {
    public String searchTerm { get; set; }
    public Account accountRecord { get; set; }
    public List<Contact> relatedContacts { get; set; }

    public AccountSearchController() {
        searchTerm = '';
        relatedContacts = new List<Contact>();
    }

    public void searchAccount() {
        if (searchTerm != null && searchTerm != '') {
            if (searchTerm.length() == 15 || searchTerm.length() == 18) {
                accountRecord = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) 
                                 FROM Account WHERE Id = :searchTerm LIMIT 1];
            } else {
                accountRecord = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) 
                                 FROM Account WHERE Name = :searchTerm LIMIT 1];
            }

            if (accountRecord != null) {
                relatedContacts = accountRecord.Contacts;
            } else {
                relatedContacts = new List<Contact>();
            }
        }
    }
}

