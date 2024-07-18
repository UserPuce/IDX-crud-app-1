import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/product_provider.dart';

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



    final productIdProv = productId == null ? null : ref.watch(productByIdProvider(productId!));

    return Scaffold(
      appBar: AppBar(
        title: productId == null
            ? const Text("Update Product")
            : const Text("Create Product"),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  if (productIdProv != null)
                    productIdProv.when(
                        data: (product) {
                          return Column(
                            children: [
                              const Text("Nombre"),
                              CustomInputText(
                                label: product.name,
                                hintText: product.name,
                                controller: nameCtrl,
                              ),

                              const Text("Precio"),
                              CustomInputText(
                                label: product.price.toString(),
                                hintText: product.price.toString(),
                                controller: priceCtrl,
                              ),

                              const Text("Stock"),
                              CustomInputText(
                                label: product.stock.toString(),
                                hintText: product.stock.toString(),
                                controller: stockCtrl,
                              ),

                              const Text("Imagen"),
                              CustomInputText(
                                label: product.urlImage,
                                hintText: product.urlImage,
                                controller: urlImageCtrl,
                              ),

                              const Text("Descripción"),
                              CustomInputText(
                                label: product.description,
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
                        loading: ()=> const CircularProgressIndicator()),

                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.blue)),
                      onPressed: () {},
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          productId == null ?"Crear": "Actualizar",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
