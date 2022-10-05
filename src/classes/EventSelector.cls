public with sharing class EventSelector {

    public static List<Event> selectAllEvent(Set<Date> dates) {
        return [
                SELECT WhoId, WhatId, OwnerId, StartDateTime, EndDateTime
                FROM Event
                WHERE ActivityDate IN :dates
        ];
    }
}