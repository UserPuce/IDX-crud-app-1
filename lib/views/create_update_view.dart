import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/product_provider.dart';
import 'package:myapp/routes/app_routes.dart';
import 'package:myapp/types/product.dart';

import '../widgets/custom_input_text.dart';
import '../widgets/drawer_widget.dart';

class CreateUpdateView extends ConsumerWidget {
  final String? productId;
  const CreateUpdateView({super.key, this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController priceCtrl = TextEditingController();
    final TextEditingController stockCtrl = TextEditingController();
    final TextEditingController urlImageCtrl = TextEditingController();
    final TextEditingController descriptionCtrl = TextEditingController();

    final productIdProv = productId == null
        ? ref.watch(productEmptyProvider)
        : ref.watch(productByIdProvider(productId!));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          productId == null ? "Create Product" : "Update Product",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productIdProv.when(
              data: (product) {
                if (productId != null) {
                  nameCtrl.text = product.name;
                  priceCtrl.text = product.price.toString();
                  stockCtrl.text = product.stock.toString();
                  urlImageCtrl.text = product.urlImage;
                  descriptionCtrl.text = product.description;
                }
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Product Details",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomInputText(
                        label: 'Name product',
                        hintText: product.name,
                        controller: nameCtrl,
                      ),
                      const SizedBox(height: 20),
                      CustomInputText(
                        label: 'Prices',
                        hintText: product.price.toString(),
                        controller: priceCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 20),
                      CustomInputText(
                        label: 'Stock',
                        hintText: product.stock.toString(),
                        controller: stockCtrl,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 20),
                      CustomInputText(
                        label: 'URL Image',
                        hintText: product.urlImage,
                        controller: urlImageCtrl,
                      ),
                      const SizedBox(height: 20),
                      CustomInputText(
                        label: 'Description',
                        hintText: product.description,
                        controller: descriptionCtrl,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ), backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            final Product productSubmit = Product(
                              id: productId ?? '',
                              name: nameCtrl.text,
                              price: double.parse(priceCtrl.text),
                              stock: double.parse(stockCtrl.text),
                              urlImage: urlImageCtrl.text,
                              description: descriptionCtrl.text,
                              v: 0,
                            );

                            if (productId == null) {
                              // Create
                              ref.read(createProductProvider(productSubmit));
                            } else {
                              // Update
                              ref.read(updateProductProvider(productSubmit));
                            }

                            context.push(AppRoutes.productsListView);
                            ref.invalidate(productsProvider);
                          },
                          child: Text(
                            //uso la misma vista dependiendo si es create o update
                            productId == null ? 'Create' : 'Update',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (err, trc) {
                return Column(
                  children: [Text('$err'), Text('$trc')],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
