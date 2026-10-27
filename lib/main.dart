import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'state/cart_state.dart';
import 'theme/app_theme.dart';

/// Gün 1: Flutter'a Giriş, Stateless ve Stateful Widget Mantığı
/// Gün 3: Sayfa Mantığı, MaterialApp ve Rotalar
/// Gün 5: Mini Katalog Uygulaması Final Yapısı
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key});

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  // Gün 5: Uygulama genelinde sepet durumunu yöneten tekil nesne
  late final CartState _cartState;

  @override
  void initState() {
    super.initState();
    _cartState = CartState();
  }

  @override
  void dispose() {
    _cartState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CartScope ile tüm alt widget'lara sepet durumunu sağlar
    return CartScope(
      cartState: _cartState,
      child: MaterialApp(
        title: 'Mini Katalog Uygulaması',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
