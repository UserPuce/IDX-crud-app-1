import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';

class ProductDetailWidget extends StatelessWidget {
  final String id;
  final String url;
  final String name;
  final double price;
  final double stock;
  final String description;
  const ProductDetailWidget({
    super.key,
    required this.id,
    required this.url,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          url,
                          width: 175,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 125,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 125,
                              child: Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                            Text(
                              '\$ $price', // Formato de precio
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Stock: $stock', // Formato de precio
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    onPressed: () => context.push(Uri(
                        path: AppRoutes.createUpdate,
                        queryParameters: {'productId': id}).toString()),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Actualizar",
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
      ],
    );
  }
}
