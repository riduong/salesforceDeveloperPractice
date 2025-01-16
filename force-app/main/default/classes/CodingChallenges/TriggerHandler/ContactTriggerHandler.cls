public with sharing class ContactTriggerHandler {
    public static void main() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                setDefaultEmail(Trigger.new);
                preventDuplicatePhoneNumbers(Trigger.new);
            }
        }
    }

    public static void setDefaultEmail(List<Contact> contacts) {
        for (Contact contact : contacts) {
            if (String.isEmpty(contact.Email)) {
                contact.Email = 'default@email.com'; // Default email value
            }
        }
    }  
    
    public static void preventDuplicatePhoneNumbers(List<Contact> contacts) {
        Set<String> phoneNumbers = new Set<String>();
        Set<String> duplicatePhones = new Set<String>();

        for (Contact contact : contacts) {
            if (contact.Phone != null) {
                phoneNumbers.add(contact.Phone);
            }
        }

        List<Contact> existingContacts = [SELECT Id, Phone FROM Contact WHERE Phone IN :phoneNumbers];

        for (Contact existingContact : existingContacts) {
            duplicatePhones.add(existingContact.Phone);
        }

        for (Contact contact : contacts) {
            if (contact.Phone != null && duplicatePhones.contains(contact.Phone)) {
                contact.Phone.addError('Contacts cant have duplicate phone numbers');
            }
        }

    }
}