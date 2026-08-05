import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/CartProvider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,

              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];

                return ListTile(
                  leading: Image.network(product.image, width: 50),

                  title: Text(product.title),

                  subtitle: Text("\$${product.price}"),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),

                    onPressed: () {
                      cartProvider.removeFromCart(product);
                    },
                  ),
                );
              },
            ),
          ),

          Text(
            "Total: \$${cartProvider.totalPrice}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
