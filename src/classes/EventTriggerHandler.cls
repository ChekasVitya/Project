public with sharing class EventTriggerHandler {
    public static void handle(List<Event> events, TriggerOperation triggerOperation) {
        switch on triggerOperation {
            when BEFORE_INSERT {
                EventService.checkEventsToCollision(events);
            }
            when BEFORE_UPDATE {
                EventService.checkEventsToCollision(events);
            }
        }
    }
}