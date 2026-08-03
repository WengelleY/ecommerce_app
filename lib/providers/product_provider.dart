import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Private states
  List<Product> _products = [];

  bool _isLoading = false;

  String? _errorMessage;

  // Getters
  List<Product> get products => _products;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    // Start loading
    _isLoading = true;

    // Remove old errors
    _errorMessage = null;

    notifyListeners();

    try {
      // Get products from API
      _products = await _apiService.getProducts();
    } catch (e) {
      // Save error message
      _errorMessage = "Failed to load products.";
    }

    // Stop loading
    _isLoading = false;

    notifyListeners();
  }
}
