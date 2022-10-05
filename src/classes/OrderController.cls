public with sharing class OrderController {
    @AuraEnabled(Cacheable=true)
    public static List<User> getUserIdByOrderId(Id orderId) {
        return [
                SELECT Name, Username, Email, Phone
                FROM User
                WHERE Id IN (
                        SELECT OwnerId
                        FROM Order
                        WHERE Id = :orderId
                )
        ];
    }
}