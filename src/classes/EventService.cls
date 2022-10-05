public with sharing class EventService {
    public static void checkEventsToCollision(List<Event> newEvents) {
        Set<Date> dates = new Set<Date>();
        for (Event event : newEvents) {
            dates.add(Date.newInstance(event.StartDateTime.year(), event.StartDateTime.month(), event.StartDateTime.day()));
            dates.add(Date.newInstance(event.EndDateTime.year(), event.EndDateTime.month(), event.EndDateTime.day()));
        }
        List<Event> existingEvents = EventSelector.selectAllEvent(dates);
        for (Event newEvent : newEvents) {
            for (Event existingEvent : existingEvents) {
                checkToCollision(newEvent, existingEvent);
            }
        }
    }

    private static void checkToCollision(Event newEvent, Event existingEvent) {

        //newEvent.EndDateTime is superimposed on an already existing event
        Boolean a = newEvent.StartDateTime < existingEvent.StartDateTime
                && newEvent.EndDateTime > existingEvent.StartDateTime;

        //newEvent.StartDateTime is superimposed on an already existing event
        Boolean b = newEvent.StartDateTime < existingEvent.EndDateTime
                && newEvent.EndDateTime > existingEvent.EndDateTime;

        //begins and ends at the same time as the existing one
        Boolean c = newEvent.StartDateTime == existingEvent.StartDateTime
                && newEvent.EndDateTime == existingEvent.EndDateTime;

        Boolean sameUser = existingEvent.OwnerId == newEvent.OwnerId;
        Boolean sameProduct = existingEvent.WhatId == newEvent.WhatId;
        Boolean sameContact = existingEvent.WhoId == newEvent.WhoId;

        if ((a || b || c) && sameUser) {
            newEvent.addError('This user already has an appointment at this time. ' +
                    'Please choose another time.');
        } else if ((a || b || c) && sameProduct) {
            newEvent.addError('This product is not available at the time. ' +
                    'Please choose another time.');
        } else if ((a || b || c) && sameContact) {
            newEvent.addError('This contact already has an appointment at this time. ' +
                    'Please choose another time.');
        }
    }
}