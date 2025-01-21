public with sharing class GreetingController {
    public String accountName { get; set; }
    public Boolean showGreeting { get; set; }

    public GreetingController() {
        showGreeting = false;
        String accountId = ApexPages.currentPage().getParameters().get('accountId');
        if (accountId != null) {
            Account acc = [SELECT Name FROM Account WHERE Id = :accountId LIMIT 1];
            accountName = acc.Name;
        }
    }

    public void showGreetingMessage() {
        showGreeting = true;
    }
}
