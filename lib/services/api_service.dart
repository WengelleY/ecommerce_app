import 'package:dio/dio.dart';

import '../models/product.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await dio.get('https://fakestoreapi.com/products');

      final List productsJson = response.data;

      List<Product> products = [];

      for (var productJson in productsJson) {
        products.add(Product.fromJson(productJson));
      }

      return products;
    } catch (e) {
      throw Exception("Failed to fetch products: $e");
    }
  }
}
