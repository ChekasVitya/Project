public with sharing class ProductService {
    public static void setIsActiveTrue(List<Product2> product2s) {
        for(Product2 product2 : product2s){
            product2.IsActive = true;
        }
    }
}