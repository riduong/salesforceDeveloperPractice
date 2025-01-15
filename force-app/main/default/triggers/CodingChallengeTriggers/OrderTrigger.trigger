trigger OrderTrigger on Order (before insert) {
    OrderTriggerHandler.main();
}