class OrderModel {
  OrderModel({
    required this.orderId,
    required this.userId,
    required this.status,
    required this.createdAt,
    this.notes,
    required this.customer,
    required this.address,
    required this.payment,
    required this.items,
    required this.total,
  });
  factory OrderModel.fromMap(final Map<String, dynamic> data) {
    return OrderModel(
      orderId: data['order_id'],
      userId: data['user_id'],
      status: data['status'],
      createdAt: DateTime.parse(data['created_at']),
      notes: data['notes'],
      customer: CustomerInfo.fromMap(data['customer']),
      address: AddressInfo.fromMap(data['address']),
      payment: PaymentInfo.fromMap(data['payment']),
      items: (data['items'] as List)
          .map((final e) => OrderItem.fromMap(e))
          .toList(),
      total: (data['total'] as num).toDouble(),
    );
  }
  final String orderId;
  final String userId;
  final String status;
  final DateTime createdAt;
  final String? notes;

  final CustomerInfo customer;
  final AddressInfo address;
  final PaymentInfo payment;
  final List<OrderItem> items;
  final double total;

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'notes': notes,
      'customer': customer.toMap(),
      'address': address.toMap(),
      'payment': payment.toMap(),
      'items': items.map((final e) => e.toMap()).toList(),
      'total': total,
    };
  }
}

class CustomerInfo {
  factory CustomerInfo.fromMap(final Map<String, dynamic> data) {
    return CustomerInfo(name: data['name'], phone: data['phone']);
  }

  CustomerInfo({required this.name, required this.phone});
  final String name;
  final String phone;

  Map<String, dynamic> toMap() => {'name': name, 'phone': phone};
}

class AddressInfo {
  AddressInfo({
    required this.city,
    required this.area,
    required this.addressLine1,
    required this.postalCode,
    required this.lng,
  });

  factory AddressInfo.fromMap(final Map<String, dynamic> data) {
    return AddressInfo(
      city: data['city'],
      area: data['area'],
      addressLine1: data['address_line_1'],
      postalCode: (data['postalCode'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
    );
  }
  final String city;
  final String area;
  final String addressLine1;
  final double postalCode;
  final double lng;

  Map<String, dynamic> toMap() => {
    'city': city,
    'area': area,
    'address_line_1': addressLine1,
    'postalCode': postalCode,
  };
}

class PaymentInfo {
  PaymentInfo({
    required this.paymentMethod,
    required this.paymentStatus,
    required this.transactionId,
    required this.currency,
  });

  factory PaymentInfo.fromMap(final Map<String, dynamic> data) {
    return PaymentInfo(
      paymentMethod: data['payment_method'],
      paymentStatus: data['payment_status'],
      transactionId: data['transaction_id'],
      currency: data['currency'],
    );
  }
  final String paymentMethod;
  final String paymentStatus;
  final String transactionId;
  final String currency;

  Map<String, dynamic> toMap() => {
    'payment_method': paymentMethod,
    'payment_status': paymentStatus,
    'transaction_id': transactionId,
    'currency': currency,
  };
}

class OrderItem {
  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.finalPrice,
    required this.image,
  });

  factory OrderItem.fromMap(final Map<String, dynamic> data) {
    return OrderItem(
      productId: data['product_id'].toString(),
      productName: data['product_name'],
      quantity: data['quantity'],
      price: (data['price'] as num).toDouble(),
      finalPrice: (data['final_price'] as num).toDouble(),
      image: data["image"] ?? "",
    );
  }
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final double finalPrice;
  final String image;

  Map<String, dynamic> toMap() => {
    'product_id': productId,
    'product_name': productName,
    'quantity': quantity,
    'price': price,
    'final_price': finalPrice,
    'image': image,
  };
}
