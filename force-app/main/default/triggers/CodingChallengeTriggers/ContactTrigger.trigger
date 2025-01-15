trigger ContactTrigger on Contact (before insert) {
    ContactTriggerHandler.main();
}