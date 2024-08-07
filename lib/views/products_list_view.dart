import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_provider.dart';
import '../widgets/card_item_product.dart';
import '../routes/app_routes.dart';

// State provider to hold the search query
final searchQueryProvider = StateProvider<String>((ref) => '');

class ProductsListView extends ConsumerStatefulWidget {
  const ProductsListView({super.key});

  @override
  ConsumerState<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends ConsumerState<ProductsListView> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    final searchQuery = ref.read(searchQueryProvider);
    searchController = TextEditingController(text: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter product name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
            ),
          ),
          Expanded(
            child: products.when(
              data: (products) {
                // Filter products based on search query
                final filteredProducts = products.where((product) {
                  return product.name.toLowerCase().contains(searchQuery.toLowerCase());
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (ctx, i) {
                    final product = filteredProducts[i];
                    return GestureDetector(
                      onTap: () {
                        context.push('${AppRoutes.productDetail}/${product.id}');
                      },
                      child: CardItemProduct(
                        title: product.name,
                        description: product.description,
                        imageUrl: product.urlImage,
                        price: product.price,
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
