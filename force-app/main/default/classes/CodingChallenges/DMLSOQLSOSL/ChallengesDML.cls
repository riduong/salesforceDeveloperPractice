public with sharing class ChallengesDML {
    public ChallengesDML() {

    }

    public static void SpawnContacts(){
        List<Contact> contactList = new List<Contact>();

        for (Integer i = 1; i < 200; i++) {
            Contact newContact = new Contact();
            newContact.FirstName = 'FirstName' + i;
            newContact.LastName = 'LastName' + i;
            contactList.add(newContact);
        }
        Database.insert contactList;
    }

    public static void CreateHomes() {
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 3; i++) {
            Account acc = new Account();
            acc.Name = 'HomeAccount' + i;
            accList.add(acc);
        }
        Database.insert accList;
    }

    public static void Relocate() {
        List<Contact> recentContacts = [SELECT ID FROM CONTACT ORDER BY CreatedDate DESC Limit 50];
        Database.delete recentContacts;
    }

    
}