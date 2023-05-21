import 'home_data_model.dart';

class CartModel {
  CartModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final dynamic status;
  late final dynamic message;
  late final Data data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = null;
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    required this.cartItems,
    required this.subTotal,
    required this.total,
  });
  late final List<CartItems> cartItems;
  late final dynamic subTotal;
  late final dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    cartItems = List.from(json['cart_items'])
        .map((e) => CartItems.fromJson(e))
        .toList();
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  CartItems({
    required this.id,
    required this.quantity,
    required this.product,
  });
  late final dynamic id;
  late final dynamic quantity;
  late final Product product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(
      json['product'],
    );
  }
}

class CartChangeModel {
  CartChangeModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final dynamic status;
  late final dynamic message;
  late final DataCart data;

  CartChangeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DataCart.fromJson(json['data']);
  }
}

class DataCart {
  DataCart({
    required this.id,
    required this.product,
  });
  late final dynamic id;
  late final Product product;

  DataCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJsonCart(
      json['product'],
    );
  }
}