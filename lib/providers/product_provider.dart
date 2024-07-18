import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/types/product.dart';

// products = lista de todos los productos

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
      validateStatus: (s) => true,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    )));

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final dio = ref.watch(dioProvider);

  // final dio = Dio();

  final response = await dio.get("https://pucei.edu.ec:9101/api/v2/products");

  if (response.statusCode != 200) return [];

  final products = (response.data as List<dynamic>).map( (item) {
    return Product.fromJson(item);
  } ).toList();

  return products;
});

// productSelected = producto seleccionado en la vista product_detail_view

final productSelectedProvider = FutureProvider<Product>((ref) async {
  final dio = ref.watch(dioProvider);

  // final dio = Dio();

  final response = await dio.get("https://pucei.edu.ec:9101/api/v2/products");

  if (response.statusCode != 200) return Product(id: "", name: "err", price: 0, stock: 0, urlImage: "", description: "err", v: 0);

  final product = Product.fromJson(response.data);

  return product;
});

final productByIdProvider = FutureProvider.family<Product, String?>((ref, id) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get("https://pucei.edu.ec:9101/api/v2/products/$id");

  if (response.statusCode != 200) return Product(id: "", name: "err", price: 0, stock: 0, urlImage: "", description: "err", v: 0);

  final product = Product.fromJson(response.data);

  return product;
});