@IsTest
public with sharing class EventServiceTest {

    @TestSetup
    static void createTestData() {

        List<Contact> contacts = new List<Contact>{
                new Contact(LastName = 'TestContact1'),
                new Contact(LastName = 'TestContact2')
        };
        insert contacts;

        List<Product2> products = new List<Product2>{
                new Product2(
                        RecordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Product2' LIMIT 1],
                        Name = 'TestCar1', ProductCode = 'A-000031', Engine__c = 'Diesel', Volume__c = 1.3),
                new Product2(
                        RecordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Product2' LIMIT 1],
                        Name = 'TestCar2', ProductCode = 'A-000032', Engine__c = 'Diesel', Volume__c = 1.5)
        };
        insert products;

        List<User> users = new List<User>{
                new User(Alias = 'user', Email = 'standarduser1@testorg.com',
                        EmailEncodingKey = 'UTF-8', LastName = 'Testing1', LanguageLocaleKey = 'en_US',
                        LocaleSidKey = 'en_US', ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
                        TimeZoneSidKey = 'America/Los_Angeles', Username = 'standarduser1@vityachekas.com'),
                new User(Alias = 'stan', Email = 'standarduser2@testorg.com',
                        EmailEncodingKey = 'UTF-8', LastName = 'Testing2', LanguageLocaleKey = 'en_US',
                        LocaleSidKey = 'en_US', ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
                        TimeZoneSidKey = 'America/Los_Angeles', Username = 'standarduser2@vityachekas.com')
        };
        insert users;

        List<Event> events = new List<Event>{
                new Event(
                        Subject = 'Consultation', WhoId = contacts[0].Id, WhatId = products[0].Id, OwnerId = users[0].Id,
                        StartDateTime = Datetime.newInstance(2023, 9, 30, 10, 0, 0),
                        EndDateTime = Datetime.newInstance(2023, 9, 30, 11, 0, 0)
                ),
                new Event(
                        Subject = 'Consultation', WhoId = contacts[1].Id, WhatId = products[1].Id, OwnerId = users[1].Id,
                        StartDateTime = Datetime.newInstance(2023, 9, 30, 12, 0, 0),
                        EndDateTime = Datetime.newInstance(2023, 9, 30, 13, 0, 0)
                ),
                new Event(
                        Subject = 'Test drive', WhoId = contacts[1].Id, WhatId = products[1].Id, OwnerId = users[0].Id,
                        StartDateTime = Datetime.newInstance(2023, 9, 30, 14, 0, 0),
                        EndDateTime = Datetime.newInstance(2023, 9, 30, 15, 0, 0)
                )
        };
        insert events;
    }

    @IsTest
    static void testNegativeEventsInsert() {

        //given
        List<Event> events = new List<Event>();
        events.addAll(TestDataFactory.createNegativeEventsForUser());
        events.addAll(TestDataFactory.createNegativeEventsForProduct());
        events.addAll(TestDataFactory.createNegativeEventsForContact());

        //when
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(events, false);
        Test.stopTest();

        //then
        System.assertEquals(3, [SELECT COUNT() FROM Event]);
        for (Database.SaveResult result : results) {
            System.assert(result.isSuccess() == false);
            System.assert(result.getErrors().size() == 1);
        }

    }

    @IsTest
    static void testPositiveEventsInsert() {

        //given
        List<Event> events = new List<Event>();
        events.addAll(TestDataFactory.createPositiveEventsForUser());
        events.addAll(TestDataFactory.createPositiveEventsForProduct());
        events.addAll(TestDataFactory.createPositiveEventsForContact());

        //when
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(events, false);
        Test.stopTest();

        //then
        for (Database.SaveResult result : results) {
            System.assertEquals(true, result.isSuccess());
            System.assertEquals(0, result.getErrors().size());
        }
        System.assertEquals(12, [SELECT COUNT() FROM Event]);
    }

    @IsTest
    static void testNegativeEventsUpdate() {

        //given
        Event event = [SELECT Id, StartDateTime, EndDateTime FROM Event WHERE Subject = 'Test drive' LIMIT 1];

        //when
        Test.startTest();
        event.StartDateTime = Datetime.newInstance(2023, 9, 30, 10, 1, 0);
        event.EndDateTime = Datetime.newInstance(2023, 9, 30, 11, 1, 0);
        Database.SaveResult result = Database.update(event, false);
        Test.stopTest();

        //then
        System.assertEquals(false, result.isSuccess());
        System.assertEquals(1, result.getErrors().size());
    }
}