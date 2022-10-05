public with sharing class OrderService {
    public static void updateProductIsActiveCheckbox(List<Order> orders) {
        List<Product2> products = new List<Product2>();

        Set<String> orderIds = new Set<String>();
        for (Order order:orders){
            if(order.Status == 'Activated'){
                orderIds.add(order.Id);
            }
        }
        List<OrderItem> orderItems = OrderItemSelector.selectOrderItemsForOrdersIds(orderIds);

        Set<String> productIdsToUpdate = new Set<String>();
        for(OrderItem orderItem: orderItems){
            productIdsToUpdate.add(orderItem.Product2Id);
        }

        for (Product2 product : Product2Selector.selectProductForIds(productIdsToUpdate)){
            product.IsActive = false;
            products.add(product);
        }

        update products;
    }
}