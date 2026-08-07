import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/CartProvider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: Image.network(
                  product.image,

                  height: 280,

                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                product.title,

                style: const TextStyle(
                  fontSize: 22,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "\$${product.price}",

                style: const TextStyle(
                  fontSize: 24,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                product.category.toUpperCase(),

                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: () {
                    cartProvider.addToCart(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to cart"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),

                  label: const Text("Add to Cart"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
