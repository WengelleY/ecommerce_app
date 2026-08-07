import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/CartProvider.dart';
import '../providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),

        actions: [
          IconButton(
            icon: const Icon(Icons.person),

            onPressed: () {
              context.push('/profile');
            },
          ),

          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),

                    onPressed: () {
                      context.push('/cart');
                    },
                  ),

                  if (cartProvider.cartItems.isNotEmpty)
                    Positioned(
                      right: 5,
                      top: 5,

                      child: Container(
                        padding: const EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),

                        child: Text(
                          cartProvider.cartItems.length.toString(),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),

            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),

              onChanged: (value) {
                productProvider.searchProducts(value);
              },
            ),
          ),

          _buildCategories(productProvider),

          Expanded(child: _buildBody(productProvider)),
        ],
      ),
    );
  }

  Widget _buildCategories(ProductProvider productProvider) {
    final categories = [
      "all",
      "electronics",
      "jewelery",
      "men's clothing",
      "women's clothing",
    ];

    return SizedBox(
      height: 60,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        itemCount: categories.length,

        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),

            child: ElevatedButton(
              onPressed: () {
                productProvider.changeCategory(category);
              },

              child: Text(category),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ProductProvider productProvider) {
    // Loading state

    if (productProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state

    if (productProvider.errorMessage != null) {
      return Center(child: Text(productProvider.errorMessage!));
    }

    // Empty state

    if (productProvider.filteredProducts.isEmpty) {
      return const Center(child: Text("No products available"));
    }

    // Success state

    return ListView.builder(
      itemCount: productProvider.filteredProducts.length,

      itemBuilder: (context, index) {
        final product = productProvider.filteredProducts[index];

        return InkWell(
          onTap: () {
            context.push('/product', extra: product);
          },

          child: Card(
            margin: const EdgeInsets.all(10),

            child: Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Image.network(
                    product.image,

                    height: 180,

                    width: double.infinity,

                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    product.title,

                    style: const TextStyle(
                      fontSize: 18,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "\$${product.price}",

                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
