import 'package:dio/dio.dart'; // Importa la biblioteca Dio para hacer solicitudes HTTP.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Flutter Riverpod para la gestión del estado.
import 'package:myapp/types/product.dart'; // Importa la clase Product definida en la aplicación.

// Proveedor de Dio configurado con opciones predeterminadas como tiempos de espera y validación de estado.
final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
      validateStatus: (s) => true, // Siempre considera las respuestas como válidas.
      connectTimeout: const Duration(seconds: 5), // Tiempo máximo para establecer conexión.
      receiveTimeout: const Duration(seconds: 3), // Tiempo máximo para recibir respuesta.
    )));

// Proveedor que obtiene la lista de productos desde una API.
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final dio = ref.watch(dioProvider); // Obtiene la instancia de Dio del proveedor.

  final response = await dio.get("http://141.148.55.107:9101/api/v2/products"); // Hace una solicitud GET a la API.

  if (response.statusCode != 200) return []; // Si la respuesta no es 200, devuelve una lista vacía.

  // Mapea los datos recibidos a una lista de productos.
  final products = (response.data as List<dynamic>).map((item) {
    return Product.fromJson(item); // Convierte cada elemento JSON a un objeto Product.
  }).toList();

  return products; // Devuelve la lista de productos.
});

// Proveedor que obtiene un producto por su ID.
final productByIdProvider =
    FutureProvider.family<Product, String?>((ref, id) async {
  final dio = ref.watch(dioProvider); // Obtiene la instancia de Dio del proveedor.

  final response =
      await dio.get("http://141.148.55.107:9101/api/v2/products/$id"); // Hace una solicitud GET con el ID del producto.

  if (response.statusCode != 200) {
    // Si la respuesta no es 200, devuelve un producto de error.
    return Product(
        id: "",
        name: "err",
        price: 0,
        stock: 0,
        urlImage: "",
        description: "err",
        v: 0);
  }

  final product = Product.fromJson(response.data); // Convierte el JSON a un objeto Product.

  return product; // Devuelve el producto.
});

// Proveedor que devuelve un producto vacío, utilizado para crear un nuevo producto.
final productEmptyProvider = FutureProvider((ref) {
  return Product(
      id: '',
      name: 'err',
      price: 0,
      stock: 0,
      urlImage: '',
      description: 'description',
      v: 0);
});

// Proveedor para crear un nuevo producto.
final createProductProvider =
    FutureProvider.family<Product, Product>((ref, product) async {
  final dio = ref.watch(dioProvider); // Obtiene la instancia de Dio del proveedor.

  final response = await dio.post<Product>(
      'http://141.148.55.107:9101/api/v2/products',
      data: {
        "name": product.name,
        "price": product.price,
        "stock": product.stock,
        "urlImage": product.urlImage,
        "description": product.description,
        "v": 0
      }); // Hace una solicitud POST para crear un nuevo producto.

  if (response.statusCode != 201) {
    // Si la respuesta no es 201, devuelve un producto de error.
    return Product(
        id: '',
        name: 'err',
        price: 0,
        stock: 0,
        urlImage: '',
        description: 'description',
        v: 0);
  }

  return response.data!; // Devuelve el producto creado.
});

// Proveedor para actualizar un producto existente.
final updateProductProvider =
    FutureProvider.family<Product, Product>((ref, product) async {
  final dio = ref.watch(dioProvider); // Obtiene la instancia de Dio del proveedor.

  final response = await dio.patch<Product>(
      'http://141.148.55.107:9101/api/v2/products/${product.id}',
      data: {
        "name": product.name,
        "price": product.price,
        "stock": product.stock,
        "urlImage": product.urlImage,
        "description": product.description,
        "v": 0
      }); // Hace una solicitud PATCH para actualizar el producto.

  if (response.statusCode != 200) {
    // Si la respuesta no es 200, devuelve un producto de error.
    return Product(
        id: '',
        name: 'err',
        price: 0,
        stock: 0,
        urlImage: '',
        description: 'description',
        v: 0);
  }

  return response.data!; // Devuelve el producto actualizado.
});

// Proveedor para eliminar un producto por su ID.
final deleteProductProvider =
    FutureProvider.family<Product, String>((ref, id) async {
  final dio = ref.watch(dioProvider); // Obtiene la instancia de Dio del proveedor.

  final response = await dio
      .delete<Product>('http://141.148.55.107:9101/api/v2/products/$id'); // Hace una solicitud DELETE para eliminar el producto.

  if (response.statusCode != 200) {
    // Si la respuesta no es 200, devuelve un producto de error.
    return Product(
        id: '',
        name: 'err',
        price: 0,
        stock: 0,
        urlImage: '',
        description: 'description',
        v: 0);
  }

  return response.data!; // Devuelve el producto eliminado.
});
