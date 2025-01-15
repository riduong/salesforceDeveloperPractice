trigger AccountTrigger on Account (before delete, after insert, after update) {
    AccountTriggerHandler.main();
}