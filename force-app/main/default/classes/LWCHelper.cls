public with sharing class LWCHelper {
    @AuraEnabled(cacheable=true)
    public static Contact getContact() {
        return [SELECT Name, Email FROM Contact LIMIT 1];
    }
}