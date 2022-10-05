trigger OrderTrigger on Order (after update) {
    OrderTriggerHandler.handle(Trigger.new, Trigger.operationType);
}