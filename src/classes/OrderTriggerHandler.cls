public with sharing class OrderTriggerHandler {
    public static void handle(List<Order> orders, TriggerOperation triggerOperation) {
        switch on triggerOperation {
            when AFTER_UPDATE {
                OrderService.updateProductIsActiveCheckbox(orders);
            }
        }
    }
}