import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    apiService.getProducts();

    return const MaterialApp(
      home: Scaffold(body: Center(child: Text("Check Console"))),
    );
  }
}
