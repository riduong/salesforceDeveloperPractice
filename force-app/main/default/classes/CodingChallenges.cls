public with sharing class CodingChallenges {
    public CodingChallenges() {
    }

    public static class_Delivery__c createClassDelivery(Id userId) {
        if (!Schema.sObjectType.class_Delivery__c.isCreateable()) {
            throw new MyCustomException('User cant create class delivery'); 
        }

        class_Delivery__c newDelivery = new class_Delivery__c(Name='New Class Delivery', Course__c = 'Apex Programming');

        if(!Schema.sObjectType.class_Delivery__c.fields.Name.isCreateable() ||
        !Schema.sObjectType.class_Delivery__c.fields.Course__c.isCreateable()) {
            throw new MyCustomException('User does not have access to the fields');
        }
        insert newDelivery;
        return newDelivery;
    }

    public static void deleteClassDelivery(Id deliveryId) {
        if(!Schema.sObjectType.class_Delivery__c.isDeletable()) {
            throw new MyCustomException('User does not have permission to Delete');
        }

        class_Delivery__c deliveryToDelete = [SELECT Id FROM class_Delivery__c WHERE Id = :deliveryId LIMIT 1];

        delete deliveryToDelete;

    }

    public static void changeCourseToDotNet(Id deliveryId) {
        if(!Schema.sObjectType.Class_Delivery__c.isUpdateable()) {
            throw new MyCustomException('User does not have permission to update');
        }

        class_Delivery__c deliveryToUpdate = [SELECT Id, Course__c FROM class_Delivery__c WHERE Id = :deliveryId LIMIT 1];

        deliveryToUpdate.Course__c = 'DotNet Programming';

        update deliveryToUpdate;
    }

    public class MyCustomException extends Exception{}

}