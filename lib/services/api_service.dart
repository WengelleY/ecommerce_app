import 'package:dio/dio.dart';
import '../models/product.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> getProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');

      final List productsJson = response.data;

      for (var productJson in productsJson) {
        Product product = Product.fromJson(productJson);

        print(product.title);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
