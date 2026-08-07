import 'package:flutter/material.dart';
import '../models/cart_item.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);

    notifyListeners();
  }

  double get totalPrice {
    double total = 0;

    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }

    return total;
  }

  void increaseQuantity(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _cartItems[index].quantity++;

      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }

      notifyListeners();
    }
  }
}
