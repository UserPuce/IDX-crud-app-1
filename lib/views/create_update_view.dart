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
        title: productId == null
            ? const Text("Create Product")
            : const Text("Update Product"),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  productIdProv.when(
                      data: (product) {
                        if(productId != null){
                          // Update inputs controllers
                          nameCtrl.text = product.name;
                          priceCtrl.text = product.price.toString();
                          stockCtrl.text = product.stock.toString();
                          urlImageCtrl.text = product.urlImage;
                          descriptionCtrl.text = product.description;
                        }
                        return Column(
                          children: [
                            const Text("Name product"),
                            CustomInputText(
                              label: 'Name product',
                              hintText: product.name,
                              controller: nameCtrl,
                            ),
                            const Text("Price"),
                            CustomInputText(
                              label: 'Price',
                              hintText: product.price.toString(),
                              controller: priceCtrl,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                            const Text("Stock"),
                            CustomInputText(
                              label: 'Stock',
                              hintText: product.stock.toString(),
                              controller: stockCtrl,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                            const Text("URL Image"),
                            CustomInputText(
                              label: 'URL Image',
                              hintText: product.urlImage,
                              controller: urlImageCtrl,
                            ),
                            const Text("Description"),
                            CustomInputText(
                              label: 'Description',
                              hintText: product.description,
                              controller: descriptionCtrl,
                            ),
                          ],
                        );
                      },
                      error: (err, trc) {
                        return Column(
                          children: [Text('$err'), Text('$trc')],
                        );
                      },
                      loading: () => const CircularProgressIndicator()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.blue)),
                      onPressed: () async {
                        // print();
                        final Product productSubmit = Product(
                            id: productId ?? '',
                            name: nameCtrl.text,
                            price: double.parse(priceCtrl.text),
                            stock: double.parse(stockCtrl.text),
                            urlImage: urlImageCtrl.text,
                            description: descriptionCtrl.text,
                            v: 0);

                        if(productId == null){
                          // Crear
                          ref.read(createProductProvider(productSubmit));
                        }else {
                          // Actualizar
                          ref.read(updateProductProvider(productSubmit));
                        }

                        ref.invalidate(productsProvider);
                        context.push(AppRoutes.productsListView);
                      },
                      child: Text(
                        productId == null ? 'Create' : 'Update',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
