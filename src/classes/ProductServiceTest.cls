@IsTest
public with sharing class ProductServiceTest {

    @IsTest
    static void testOneProductInsert() {

        //giver
        Integer num = 1;
        List<Product2> products = TestDataFactory.createProducts(num);

        //when
        Test.startTest();
        insert products;
        Test.stopTest();

        //then
        System.assertEquals(num, [SELECT COUNT() FROM Product2]);
        System.assertEquals(true, [SELECT IsActive FROM Product2].IsActive);

    }

    @IsTest
    static void testListProductsInsert() {

        //giver
        Integer num = 10;
        List<Product2> products = TestDataFactory.createProducts(num);

        //when
        Test.startTest();
        insert products;
        Test.stopTest();

        //then
        System.assertEquals(num, [SELECT COUNT() FROM Product2]);
        List<Product2> product2s = [SELECT IsActive FROM Product2];
        for (Product2 product2 : product2s) {
            System.assertEquals(true, product2.IsActive);
        }
    }
}