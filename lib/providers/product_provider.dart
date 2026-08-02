import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await _apiService.getProducts();

    notifyListeners();
  }
}
