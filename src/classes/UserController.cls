public with sharing class UserController {
    @AuraEnabled(Cacheable=true)
    public static List<User> getUser() {
        return [
                SELECT Name, Username, Email, Phone, IsActive, City, UserRoleId
                FROM User
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Order> relatedOrder(String keySearch) {
        return [
                SELECT Id, OrderNumber, CustomerAuthorizedById, TotalAmount, Status
                FROM Order
                WHERE OwnerId IN (
                        SELECT Id
                        FROM User
                        WHERE Name = :keySearch
                )
        ];
    }
}