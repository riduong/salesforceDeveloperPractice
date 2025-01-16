public with sharing class OrderTriggerHandler {
    public static void main() {
        addPortableProductToOrder(Trigger.new);
    }

    public static void addPortableProductToOrder(List<Order> orders) {
        Product2 portableProduct = [SELECT Id FROM Product2 WHERE Name = 'Installation: Portable Product' LIMIT 1];

        for (Order order : orders) {
            List<OrderItem> existingOrderItems = [SELECT Product2Id FROM OrderItem WHERE OrderId = :order.Id AND Product2Id = :portableProduct.Id];

            if (existingOrderItems.isEmpty()) {
                OrderItem newOrderItem = new OrderItem(
                    OrderId = order.Id,
                    Product2Id = portableProduct.Id,
                    Quantity = 1,
                    UnitPrice = 0
                );
                insert newOrderItem;
            }
        }
    }
}