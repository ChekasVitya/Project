@IsTest
public with sharing class TestDataFactory {


    public static List<Event> createNegativeEventsForUser() {
        return createNegativeEvents(
                [SELECT Id FROM Contact WHERE LastName = 'TestContact2'].Id,
                [SELECT Id FROM Product2 WHERE Name = 'TestCar2'].Id,
                [SELECT Id FROM User WHERE LastName = 'Testing1'].Id
        );
    }

    public static List<Event> createNegativeEventsForProduct() {
        return createNegativeEvents(
                [SELECT Id FROM Contact WHERE LastName = 'TestContact2'].Id,
                [SELECT Id FROM Product2 WHERE Name = 'TestCar1'].Id,
                [SELECT Id FROM User WHERE LastName = 'Testing2'].Id);
    }

    public static List<Event> createNegativeEventsForContact() {
        return createNegativeEvents(
                [SELECT Id FROM Contact WHERE LastName = 'TestContact1'].Id,
                [SELECT Id FROM Product2 WHERE Name = 'TestCar2'].Id,
                [SELECT Id FROM User WHERE LastName = 'Testing2'].Id
        );
    }

    public static List<Event> createNegativeEvents(String whoId, String whatId, String ownerId) {
        List<Event> events = new List<Event>();
        for (Integer i = 0; i < 60; i++) {
            events.add(new Event(
                    Subject = 'Consultation', WhoId = whoId, WhatId = whatId, OwnerId = ownerId,
                    StartDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 10, 0 + i, 0),
                    EndDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 11, 0 + i, 0)
            ));
            events.add(new Event(
                    Subject = 'Consultation', WhoId = whoId, WhatId = whatId, OwnerId = ownerId,
                    StartDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 10, 0 - i, 0),
                    EndDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 11, 0 - i, 0)
            ));
        }
        return events;
    }

    public static List<Event> createPositiveEventsForUser() {
        return createPositiveEvents(
                [SELECT Id FROM Contact WHERE LastName = 'TestContact2'].Id,
                [SELECT Id FROM Product2 WHERE Name = 'TestCar2'].Id,
                [SELECT Id FROM User WHERE LastName = 'Testing1'].Id
        );
    }

    public static List<Event> createPositiveEventsForProduct() {
        return createPositiveEvents(
                [SELECT Id FROM Contact WHERE LastName = 'TestContact2'].Id,
                [SELECT Id FROM Product2 WHERE Name = 'TestCar1'].Id,
                [SELECT Id FROM User WHERE LastName = 'Testing2'].Id
        );
    }

    public static List<Event> createPositiveEventsForContact() {
        return createPositiveEvents(
                [SELECT Id FROM Contact WHERE LastName = 'TestContact1'].Id,
                [SELECT Id FROM Product2 WHERE Name = 'TestCar2'].Id,
                [SELECT Id FROM User WHERE LastName = 'Testing2'].Id
        );
    }

    public static List<Event> createPositiveEvents(String contactId, String productId, String userId) {
        return new List<Event>{
                new Event(
                        Subject = 'Consultation', WhoId = contactId, WhatId = productId, OwnerId = userId,
                        StartDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 9, 0, 0),
                        EndDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 10, 0, 0)
                ),
                new Event(
                        Subject = 'Consultation', WhoId = contactId, WhatId = productId, OwnerId = userId,
                        StartDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 11, 0, 0),
                        EndDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 12, 0, 0)
                ),
                new Event(
                        Subject = 'Consultation', WhoId = contactId, WhatId = productId, OwnerId = userId,
                        StartDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 5, 0, 0),
                        EndDateTime = Datetime.newInstance(Datetime.now().year() + 1, 9, 30, 6, 0, 0)
                )
        };
    }

    public static List<Product2> createProducts(Integer num) {
        List<Product2> products = new List<Product2>();
        for (Integer i = 0; i < num; i++) {
            products.add(
                    new Product2(
                            RecordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Product2' LIMIT 1],
                            Name = 'TestCar', ProductCode = 'A-000032', Engine__c = 'Diesel', Volume__c = 1.3
                    )
            );
        }
        return products;
    }
}