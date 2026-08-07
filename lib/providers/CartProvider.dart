import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/cart_item.dart';
import '../core/storage/cart_storage.dart';

class CartProvider extends ChangeNotifier {
  final CartStorage _cartStorage = CartStorage();

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Load saved cart when app starts
  Future<void> loadCart() async {
    _cartItems = await _cartStorage.getCart();

    notifyListeners();
  }

  // Save cart to local storage
  Future<void> saveCart() async {
    await _cartStorage.saveCart(_cartItems);
  }

  // Add product
  void addToCart(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1));
    }

    saveCart();

    notifyListeners();
  }

  // Remove completely
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);

    saveCart();

    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(Product product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _cartItems[index].quantity++;

      saveCart();

      notifyListeners();
    }
  }

  // Decrease quantity
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

      saveCart();

      notifyListeners();
    }
  }

  // Calculate total price
  double get totalPrice {
    double total = 0;

    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }

    return total;
  }
}
