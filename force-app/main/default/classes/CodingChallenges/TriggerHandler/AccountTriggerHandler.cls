public with sharing class AccountTriggerHandler {
    public static void main() {
        switch on Trigger.operationType {
            when BEFORE_DELETE {
                preventAccountDeletion(Trigger.old);
            }
            when AFTER_INSERT {
                createRelatedContact(Trigger.new);
            }
            when AFTER_UPDATE {
                updateAccountPhone(Trigger.new,Trigger.old);
            }
        }
    }
    public static void preventAccountDeletion(List<Account> accounts) {
        Set<Id> accountIds = new Set<Id>();

        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }

        List<Contact> relatedContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds];

        if (!relatedContacts.isEmpty()) {
            for (Account acc : accounts) {
                acc.addError('Account cant be deleted if it has a Contact.');
            }
        }
    }

    public static void createRelatedContact(List<Account> newAccounts) {
        List<Contact> contactsToInsert = new List<Contact>();

        for (Account acc : newAccounts) {
            Contact con = new Contact(
                FirstName = 'RelatedContact', 
                LastName = acc.Name, 
                AccountId = acc.Id,
                Email = 'default@email.com'
            );
            contactsToInsert.add(con);
        }

        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }

    public static void updateAccountPhone(List<Account> updatedAccounts, List<Account> oldAccounts) {
        Set<Id> accountIds = new Set<Id>();

        for (Account acc : updatedAccounts) {
            accountIds.add(acc.Id);
        }

        List<Contact> updatedContacts = [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId IN :accountIds];

        for (Contact con : updatedContacts) {
            for (Account acc : updatedAccounts) {
                if (con.AccountId == acc.Id && con.Phone != null) {
                    acc.Phone = con.Phone;
                }
            }
        }

        if (!updatedAccounts.isEmpty()) {
            update updatedAccounts;
        }
    }
}