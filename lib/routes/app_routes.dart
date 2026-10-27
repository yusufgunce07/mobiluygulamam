import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';

/// Gün 3: Sayfa Mantığı ve Navigasyon
/// Route Kavramı, Named Routes, MaterialPageRoute ve Route Arguments
class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
  static const String cart = '/cart';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case detail:
        // Gün 3: Sayfalar Arasi Veri Tasima (Route Arguments)
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
          settings: settings,
        );

      case cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }
  }
}
