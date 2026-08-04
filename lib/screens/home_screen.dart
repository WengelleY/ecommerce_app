import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
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

    // Fetch products once when screen opens
    context.read<ProductProvider>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for provider updates
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),

      body: _buildBody(productProvider),
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
    if (productProvider.products.isEmpty) {
      return const Center(child: Text("No products available"));
    }

    // Success state
    return ListView.builder(
      itemCount: productProvider.products.length,

      itemBuilder: (context, index) {
        final product = productProvider.products[index];

        return InkWell(
          onTap: () {
            // Navigate to product details screen
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
