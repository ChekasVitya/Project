trigger ProductTrigger on Product2 (before insert) {
    ProductTriggerHandler.handle(Trigger.new, Trigger.operationType);
}