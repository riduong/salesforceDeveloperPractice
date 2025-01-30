public with sharing class LWCHelper {
    @AuraEnabled(cacheable=true)
    public static Contact getContact() {
        return [SELECT Name, Email FROM Contact LIMIT 1];
    }

    @AuraEnabled(cacheable=true)
    public static List<Band__c> getBands() {
        return [SELECT Id, Name, Band_Image__c, Description__c FROM Band__c];
    }
    
    @AuraEnabled(cacheable=true)
    public static Contact searchContact(String searchTerm) {
        return [SELECT Id, Name, Email FROM Contact WHERE Name LIKE :('%' + searchTerm + '%') LIMIT 1];
    }
}