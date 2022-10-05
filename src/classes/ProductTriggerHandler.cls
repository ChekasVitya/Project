public with sharing class ProductTriggerHandler {
    public static void handle(List<Product2> product2s, TriggerOperation triggerOperation) {
        switch on triggerOperation {
            when BEFORE_INSERT {
                ProductService.setIsActiveTrue(product2s);
            }
        }
    }
}