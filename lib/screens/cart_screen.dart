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
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(12),

                          child: Row(
                            children: [
                              Image.network(
                                product.image,

                                width: 70,

                                height: 70,

                                fit: BoxFit.contain,
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      product.title,

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,

                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text("\$${product.price}"),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cartProvider.decreaseQuantity(
                                              product,
                                            );
                                          },

                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
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
                                            cartProvider.increaseQuantity(
                                              product,
                                            );
                                          },

                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  cartProvider.removeFromCart(product);
                                },

                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),

                  child: Text(
                    "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",

                    style: const TextStyle(
                      fontSize: 22,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
