import 'package:flutter/material.dart';
import '../models/product.dart';

/// Gün 5: Sepet Sistemi ve Basit State Yönetimi (Simülasyon)
/// Harici paket (Provider vb.) kullanılmadan Saf Flutter ChangeNotifier ve InheritedNotifier ile yapılmıştır.
class CartState extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  /// Toplam ürün adedi (AppBar rozeti için)
  int get totalCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Ara toplam
  double get subtotal {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Kargo ücreti simülasyonu
  double get shipping => _items.isEmpty ? 0.0 : 0.0; // Ücretsiz teslimat

  /// Genel toplam
  double get total => subtotal + shipping;

  /// Sepete ürün ekleme
  void addItem(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  /// Ürün adedini artırma / azaltma
  void updateQuantity(int productId, int delta) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _items[index].quantity += delta;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Ürünü sepetten tamamen çıkarma
  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  /// Sepeti temizleme
  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// Widget agacinda CartState'e erismeyi saglayan InheritedNotifier
class CartScope extends InheritedNotifier<CartState> {
  const CartScope({
    super.key,
    required CartState cartState,
    required super.child,
  }) : super(notifier: cartState);

  static CartState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope bulunamadi! Widget agacini kontrol edin.');
    return scope!.notifier!;
  }
}
