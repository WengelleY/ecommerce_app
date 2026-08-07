import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_item.dart';

class CartStorage {
  Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();

    final cartJson = cartItems.map((item) => item.toJson()).toList();

    final cartString = jsonEncode(cartJson);

    await prefs.setString("cart", cartString);
  }

  Future<List<CartItem>> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    final cartString = prefs.getString("cart");

    if (cartString == null) {
      return [];
    }

    final cartJson = jsonDecode(cartString);

    return cartJson.map<CartItem>((item) => CartItem.fromJson(item)).toList();
  }
}
