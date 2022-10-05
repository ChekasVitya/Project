public with sharing class OrderItemSelector {
    public static List<OrderItem> selectOrderItemsForOrdersIds(Set<String> strings) {
        return [SELECT Product2Id FROM OrderItem WHERE OrderId IN :strings];
    }
}