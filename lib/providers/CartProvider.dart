import 'package:flutter/material.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);

    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);

    notifyListeners();
  }

  double get totalPrice {
    double total = 0;

    for (var product in _cartItems) {
      total += product.price;
    }

    return total;
  }
}
