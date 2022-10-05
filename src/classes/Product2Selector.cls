public with sharing class Product2Selector {
    public static List<Product2> selectProductForIds(Set<String> strings) {
        return [SELECT IsActive FROM Product2 WHERE Id IN :strings];
    }
}