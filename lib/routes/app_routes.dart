import 'package:go_router/go_router.dart';

import 'package:myapp/views/index.dart';

class AppRoutes {
  static String home = "/";
  static String createUpdate = "/create-update";
  static String productDetail = "/product-detail";
  static String productsListView = "/product-list-view";
}

final routesConfig = GoRouter(routes: [
  GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => const HomeView(),
  ),
  GoRoute(
    path: AppRoutes.createUpdate,
    builder: (context, state) {
      print(state.pathParameters);
      return const CreateUpdateView();
    },
  ),
  GoRoute(
    path: AppRoutes.productsListView,
    builder: (context, state) => const ProductsListView(),
  ),
  GoRoute(
    // path: AppRoutes.productDetail + '/:productId',
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2237042173.
    path: '${AppRoutes.productDetail}/:productId',
    builder: (context, state) => ProductDetailView(
      productId: state.pathParameters['productId'],
    ),
  ),
]);
