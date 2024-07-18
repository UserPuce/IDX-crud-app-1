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
    final productIdProv =
        productId == null ? null : ref.watch(productByIdProvider(productId!));
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
                          return Text("$product");
                        },
                        error: (err, trc) {
                          return Column(
                            children: [Text('$err'), Text('$trc')],
                          );
                        },
                        loading: ()=> const CircularProgressIndicator()),

                  const CustomInputText(),
                  // const CustomInputText(),
                  // CustomInputText(),
                  // CustomInputText(),
                  // CustomInputText(),
                  // CustomInputText(),
                  // CustomInputText(),
                  // CustomInputText(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.blue)),
                      onPressed: () {},
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Crear o Actualizar",
                          style: TextStyle(
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
