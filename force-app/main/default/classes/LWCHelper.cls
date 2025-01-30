public with sharing class LWCHelper {
    @AuraEnabled(cacheable=true)
    public static Contact getContact() {
        return [SELECT Name, Email FROM Contact LIMIT 1];
    }

    @AuraEnabled(cacheable=true)
    public static List<Band__c> getBands() {
        return [SELECT Id, Name, Band_Image__c, Description__c FROM Band__c];
    }
    
}