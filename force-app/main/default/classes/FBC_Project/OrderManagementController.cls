public class OrderManagementController {
  public Order newOrder { get; set; }
  public List<Order> orders { get; set; }
  public List<Order_Product__c> associatedProducts { get; set; }
  public Id productId { get; set; }
  public Id selectedOrderId { get; set; }
  public List<SelectOption> productOptions { get; set; }
  public List<SelectOption> orderOptions { get; set; }

  // Constructor
  public OrderManagementController() {
    newOrder = new Order();
    orders = [
      SELECT
        Id,
        Name,
        Account.Name,
        Status,
        EffectiveDate,
        Contract.ContractNumber
      FROM Order
      LIMIT 10
    ];
    associatedProducts = new List<Order_Product__c>();
    productOptions = new List<SelectOption>();
    orderOptions = new List<SelectOption>();

    // Populate product options dropdown
    List<Product2> products = [SELECT Id, Name FROM Product2];
    for (Product2 product : products) {
      productOptions.add(new SelectOption(product.Id, product.Name));
    }

    // Populate order options dropdown
    for (Order order : orders) {
      orderOptions.add(
        new SelectOption(order.Id, order.Name + ' - ' + order.Account.Name)
      );
    }
  }

  // Method to create a new order
  public PageReference createOrder() {
    try {
      insert newOrder;
      ApexPages.addmessage(
        new ApexPages.Message(
          ApexPages.Severity.CONFIRM,
          'Order created successfully.'
        )
      );
      orders = [
        SELECT
          Id,
          Name,
          Account.Name,
          Status,
          EffectiveDate,
          Contract.ContractNumber
        FROM Order
        LIMIT 10
      ];
      newOrder = new Order(); // Clear the form for a new order
      return null;
    } catch (DmlException e) {
      ApexPages.addmessage(
        new ApexPages.Message(
          ApexPages.Severity.ERROR,
          'Error creating order: ' + e.getMessage()
        )
      );
      return null;
    }
  }

  // Method to delete an order
  public void deleteOrder() {
    try {
      if (String.isBlank(selectedOrderId)) {
        ApexPages.addmessage(
          new ApexPages.Message(
            ApexPages.Severity.ERROR,
            'Order ID is missing.'
          )
        );
        return;
      }
      Order orderToDelete = [
        SELECT Id
        FROM Order
        WHERE Id = :selectedOrderId
        LIMIT 1
      ];
      delete orderToDelete;
      ApexPages.addmessage(
        new ApexPages.Message(
          ApexPages.Severity.CONFIRM,
          'Order deleted successfully.'
        )
      );
      for (Integer i = 0; i < orders.size(); i++) {
        if (orders[i].Id == orderToDelete.Id) {
          orders.remove(i);
          break;
        }
      }
    } catch (Exception e) {
      ApexPages.addmessage(
        new ApexPages.Message(
          ApexPages.Severity.ERROR,
          'Error deleting order: ' + e.getMessage()
        )
      );
    }
  }

  // Method to add a product to the order
  public void addProductToOrder() {
    if (productId != null && selectedOrderId != null) {
      try {
        Order_Product__c op = new Order_Product__c();
        op.Order__c = selectedOrderId;
        op.Product__c = productId;

        insert op;
        ApexPages.addmessage(
          new ApexPages.Message(
            ApexPages.Severity.CONFIRM,
            'Product added to the order.'
          )
        );

        // Refresh associated products for this order
        associatedProducts = [
          SELECT Product__r.Name
          FROM Order_Product__c
          WHERE Order__c = :selectedOrderId
        ];
      } catch (Exception e) {
        ApexPages.addmessage(
          new ApexPages.Message(
            ApexPages.Severity.ERROR,
            'Error adding product: ' + e.getMessage()
          )
        );
      }
    }
  }

  // Method to fetch associated products for the selected order
  public void viewAssociatedProducts() {
    if (selectedOrderId != null) {
      associatedProducts = [
        SELECT Product__r.Name
        FROM Order_Product__c
        WHERE Order__c = :selectedOrderId
      ];
    }
  }
}
