import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    // Tell provider to fetch products once
    context.read<ProductProvider>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for provider changes
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),

      body: _buildBody(productProvider),
    );
  }

  Widget _buildBody(ProductProvider productProvider) {
    // 1. Loading state
    if (productProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2. Error state
    if (productProvider.errorMessage != null) {
      return Center(child: Text(productProvider.errorMessage!));
    }

    // 3. Empty state
    if (productProvider.products.isEmpty) {
      return const Center(child: Text("No products available"));
    }

    // 4. Success state
    return ListView.builder(
      itemCount: productProvider.products.length,

      itemBuilder: (context, index) {
        final product = productProvider.products[index];

        return ListTile(
          title: Text(product.title),

          subtitle: Text("\$${product.price}"),
        );
      },
    );
  }
}
