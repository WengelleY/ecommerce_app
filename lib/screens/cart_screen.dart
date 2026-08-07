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

      body: cartProvider.cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80),

                  SizedBox(height: 20),

                  Text(
                    "Your cart is empty",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Start adding products!",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,

                    itemBuilder: (context, index) {
                      final cartItem = cartProvider.cartItems[index];

                      final product = cartItem.product;
                      return ListTile(
                        leading: Image.network(product.image, width: 50),

                        title: Text(product.title),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("\$${product.price}"),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartProvider.decreaseQuantity(product);
                                  },

                                  icon: const Icon(Icons.remove_circle_outline),
                                ),

                                Text(
                                  cartItem.quantity.toString(),

                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    cartProvider.increaseQuantity(product);
                                  },

                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
