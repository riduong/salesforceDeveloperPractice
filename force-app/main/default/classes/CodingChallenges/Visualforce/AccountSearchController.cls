public with sharing class AccountSearchController {
    public String searchTerm { get; set; } 
    public Account accountRecord { get; set; }

    public AccountSearchController() {
        searchTerm = '';
    }

    public void searchAccount() {
        if (searchTerm != null && searchTerm != '') {
            // If the search term is a valid ID, query based on ID
            if (searchTerm.length() == 15 || searchTerm.length() == 18) {
                accountRecord = [SELECT Id, Name, Industry, Type FROM Account WHERE Id = :searchTerm LIMIT 1];
            }

            else {
                accountRecord = [SELECT Id, Name, Industry, Type FROM Account WHERE Name = :searchTerm LIMIT 1];
            }
        }
    }
}
