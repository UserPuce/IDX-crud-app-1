import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir interfaces de usuario.
import 'package:go_router/go_router.dart'; // Importa el paquete go_router para manejar las rutas de navegación.

import 'package:myapp/views/index.dart'; // Importa las vistas (pantallas) que se usarán en la navegación.

class AppRoutes {
  // Definimos las rutas de la aplicación como cadenas estáticas.
  static String home = "/";
  static String createUpdate = "/create-update";
  static String productDetail = "/product-detail";
  static String productsListView = "/product-list-view";
}

// Configuramos las rutas usando GoRouter.
final routesConfig = GoRouter(
  // Definimos una vista para manejar errores, como cuando la ruta no se encuentra.
  errorBuilder: (context, state) => const Center(
    child: Text("404 not found page"), // Muestra un texto de error.
  ),
  routes: [
    // Ruta para la vista principal (HomeView).
    GoRoute(
      path: AppRoutes.home, // Ruta raíz.
      builder: (context, state) => const HomeView(), // Construye la vista HomeView.
    ),
    // Ruta para la vista de crear/actualizar (CreateUpdateView).
    GoRoute(
      path: AppRoutes.createUpdate, // Ruta para crear/actualizar.
      builder: (context, state) => CreateUpdateView(
        productId: state.uri.queryParameters["productId"], // Obtiene el parámetro productId de la URL.
      ),
    ),
    // Ruta para la vista de lista de productos (ProductsListView).
    GoRoute(
      path: AppRoutes.productsListView, // Ruta para la lista de productos.
      builder: (context, state) => const ProductsListView(), // Construye la vista ProductsListView.
    ),
    // Ruta para la vista de detalle de producto (ProductDetailView).
    GoRoute(
      path: '${AppRoutes.productDetail}/:productId', // Ruta con un parámetro dinámico productId.
      builder: (context, state) => ProductDetailView(
        productId: state.pathParameters['productId'], // Obtiene el parámetro productId de la ruta.
      ),
    ),
  ],
);
