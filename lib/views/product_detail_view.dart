import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/product_detail_widget.dart';

class ProductDetailView extends ConsumerWidget {
  final String? productId;
  const ProductDetailView({super.key, this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the product by ID
    final productByIdRef = ref.watch(productByIdProvider(productId ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail View"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const DrawerWidget(),
      body: productByIdRef.when(
        data: (item) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Details',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                  ),
                  const SizedBox(height: 20),
                  ProductDetailWidget(
                    id: item.id,
                    url: item.urlImage,
                    name: item.name,
                    price: item.price,
                    stock: item.stock,
                    description: item.description,
                  ),
                ],
              ),
            ),
          ),
        ),
        error: (error, stackTrace) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Stack trace: $stackTrace',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
