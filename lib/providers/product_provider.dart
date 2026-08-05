import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Private states
  List<Product> _products = [];

  bool _isLoading = false;

  String? _errorMessage;

  String _selectedCategory = "all";

  String _searchQuery = "";

  // Getters

  List<Product> get products => _products;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String get selectedCategory => _selectedCategory;

  String get searchQuery => _searchQuery;

  // Filtered products getter

  List<Product> get filteredProducts {
    List<Product> filtered = _products;

    // Filter by category
    if (_selectedCategory != "all") {
      filtered = filtered
          .where((product) => product.category == _selectedCategory)
          .toList();
    }

    // Filter by search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (product) => product.title.toLowerCase().contains(_searchQuery),
          )
          .toList();
    }

    return filtered;
  }

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

  void changeCategory(String category) {
    _selectedCategory = category;

    notifyListeners();
  }

  void searchProducts(String query) {
    _searchQuery = query;

    notifyListeners();
  }
}
