@IsTest
public with sharing class OrderServiceTest {

    @TestSetup
    static void createTestData() {
        Product2 p = new Product2(
                RecordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Product2' LIMIT 1],
                Name = 'TestCar1', ProductCode = 'A-000031', Engine__c = 'Diesel',
                Volume__c = 1.3
        );
        insert p;

        PricebookEntry standardPrice = new PricebookEntry(
                Pricebook2Id = Test.getStandardPricebookId(), Product2Id = p.Id,
                UnitPrice = 100, IsActive = true, UseStandardPrice = false
        );
        insert standardPrice;

        Account acc = new Account(
                Name = 'SFDCPanther.com', Rating = 'Hot', Industry = 'Banking',
                Phone = '9087654321'
        );
        insert acc;

        Order order = new Order(
                AccountId = acc.Id, EffectiveDate = System.today(),
                Status = 'Draft', PriceBook2Id = Test.getStandardPricebookId()
        );
        insert order;
        OrderItem lineItem = new OrderItem(
                OrderId = order.id, Quantity = 1, UnitPrice = 240, Product2id = p.id,
                PricebookEntryId = standardPrice.id);
        insert lineItem;
    }

    @IsTest
    static void testPositiveData() {

        //given
        Order order = [SELECT Id FROM Order LIMIT 1];

        //when
        Test.startTest();
        order.Status = 'Activated';
        update order;
        Test.stopTest();

        //then
        Product2 product2 = [SELECT Id, IsActive FROM Product2 LIMIT 1];
        System.assertEquals(false, product2.IsActive);
    }
}