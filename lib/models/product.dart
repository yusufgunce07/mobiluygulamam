// Mini Katalog Uygulamasi - Urun ve Sepet Veri Modelleri
// Gün 2 & Gün 4: Dart Temelleri, Null Safety ve JSON Islemleri

class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String currency;
  final String image;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  /// Gün 4: JSON'dan Model Nesnesi Uretme (fromJson)
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = json['specs'];
    final Map<String, String> parsedSpecs = {};

    if (rawSpecs is Map<String, dynamic>) {
      rawSpecs.forEach((key, value) {
        parsedSpecs[key] = value.toString();
      });
    }

    return Product(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as String? ?? '\$0',
      currency: json['currency'] as String? ?? 'USD',
      image: json['image'] as String? ?? '',
      specs: parsedSpecs,
    );
  }

  /// Gün 4: Model Nesnesini JSON'a Donusturme (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }

  /// Cihaz yerelinde bulunan gorsel yolu (Offline destek & Image.asset)
  String get localAssetPath {
    final fileName = image.split('/').last;
    return 'assets/images/$fileName';
  }

  /// Sayisal fiyat degeri (Sepet toplami hesaplamak icin)
  double get numericPrice {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  /// Kategori tahmini (Arama ve filtreleme icin)
  String get category {
    final lower = name.toLowerCase();
    if (lower.contains('iphone')) return 'iPhone';
    if (lower.contains('mac') || lower.contains('imac')) return 'Mac';
    if (lower.contains('ipad')) return 'iPad';
    if (lower.contains('watch')) return 'Watch';
    if (lower.contains('airpods') || lower.contains('homepod')) return 'Audio';
    if (lower.contains('vision')) return 'Vision';
    return 'Other';
  }
}

/// Sepet icindeki urun ve adet bilgisi
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.numericPrice * quantity;
}
