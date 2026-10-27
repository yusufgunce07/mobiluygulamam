import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';

/// Gün 4: JSON Simülasyonu ve Veri Yönetimi
class ProductDataService {
  /// assets/data/products.json dosyasından asenkron ürün listesi yükleme
  static Future<List<Product>> loadProductsFromAsset() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/products.json');
      final Map<String, dynamic> decoded = json.decode(jsonString);
      final List<dynamic> list = decoded['data'] ?? [];
      return list.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      // Dosya yuklenemezse veya hata olursa yedek mock veriyi doner
      return getFallbackProducts();
    }
  }

  /// Egitim simulasyonu ve test icin statik yedek urun listesi
  static List<Product> getFallbackProducts() {
    return [
      const Product(
        id: 17,
        name: 'AirPods Pro (2nd Gen)',
        tagline: 'Adaptive Audio.',
        description:
            'The AirPods Pro (2nd Generation) feature the new H2 chip, delivering smarter noise cancellation and superior sound. Adaptive Audio effectively prioritizes sounds that need your attention while reducing background noise. They offer up to 2x more Active Noise Cancellation than the previous generation, creating an oasis of silence. The MagSafe Charging Case (USB-C) now features Precision Finding and a built-in speaker. With personalized Spatial Audio, the sound is tuned specifically to your ear shape.',
        price: '\$249',
        currency: 'USD',
        image: 'https://wantapi.com/assets/images/airpods.png',
        specs: {'chip': 'H2', 'audio': 'Spatial Audio', 'case': 'USB-C'},
      ),
      const Product(
        id: 18,
        name: 'AirPods Max',
        tagline: 'Sound focused.',
        description:
            'AirPods Max reimagine over-ear headphones with an Apple-designed dynamic driver that provides high-fidelity audio. Active Noise Cancellation blocks outside noise so you can immerse yourself in what you are listening to. The knit mesh canopy and ear cushions are designed for an exceptional acoustic seal and all-day comfort. Computational audio combines custom acoustic design with the Apple H1 chip for breakthrough experiences.',
        price: '\$549',
        currency: 'USD',
        image: 'https://wantapi.com/assets/images/airpods_max.png',
        specs: {'driver': 'Dynamic', 'cancellation': 'Active Noise', 'materials': 'Mesh canopy'},
      ),
      const Product(
        id: 19,
        name: 'HomePod',
        tagline: 'Profound sound.',
        description:
            'The HomePod is a powerhouse of sound, delivering high-fidelity audio that adapts to the room it is in for the best experience. It features a high-excursion woofer and a beamforming tweeter array that creates deep bass and crystal-clear highs. With room sensing technology, it automatically tunes the sound based on its location. It works seamlessly with your Apple devices and can be used as a smart home hub.',
        price: '\$299',
        currency: 'USD',
        image: 'https://wantapi.com/assets/images/homepod.png',
        specs: {'audio': 'Computational', 'home': 'Smart Hub', 'sensing': 'Room sensing'},
      ),
      const Product(
        id: 20,
        name: 'HomePod Mini',
        tagline: 'Color-pop.',
        description:
            'The HomePod Mini is jam-packed with innovation, delivering unexpectedly big sound for a speaker of its size. At just 3.3 inches tall, it takes up almost no space but fills the entire room with rich 360-degree audio. It works effortlessly with your iPhone-hand off music just by bringing your phone close to the speaker. You can place multiple HomePod mini speakers around the house for a connected sound system.',
        price: '\$99',
        currency: 'USD',
        image: 'https://wantapi.com/assets/images/homepod_mini.png',
        specs: {'size': '3.3 inches', 'audio': '360-degree', 'colors': '5 colors'},
      ),
      const Product(
        id: 1,
        name: 'iPhone 15 Pro',
        tagline: 'Titanium. So strong. So light. So Pro.',
        description:
            'The iPhone 15 Pro is the first iPhone to feature an aerospace-grade titanium design, making it lighter and more durable than ever before. It is powered by the groundbreaking A17 Pro chip, which delivers next-level gaming performance and efficiency. The device boasts a customizable Action button and a 48MP Main camera.',
        price: '\$999',
        currency: 'USD',
        image: 'https://wantapi.com/assets/images/iphone.png',
        specs: {'chip': 'A17 Pro', 'material': 'Titanium', 'camera': '48MP Main'},
      ),
      const Product(
        id: 6,
        name: 'MacBook Pro 14"',
        tagline: 'Mind-blowing. Head-turning.',
        description:
            'MacBook Pro blast ahead with the M3 family of chips. Built on 3-nanometer technology and featuring an all-new GPU architecture, they are the most advanced chips ever built for a personal computer. Liquid Retina XDR display with up to 22 hours of battery life.',
        price: '\$1,599',
        currency: 'USD',
        image: 'https://wantapi.com/assets/images/macbook.png',
        specs: {'chip': 'M3 Pro', 'display': '14.2" XDR', 'battery': '22 hours'},
      ),
      const Product(
        id: 12,
        name: 'iPad Air',
        tagline: 'Light. Bright. Full of might.',
        description:
            'iPad Air lets you immerse yourself in whatever you are reading, watching, or creating. The 10.9-inch Liquid Retina display features advanced technologies like True Tone, P3 wide color, and an antireflective coating. Powered by the M2 chip.',
        price: '\$599',
        currency: 'USD',
        image: 'https://wantapi.com/assets/images/ipad_air.png',
        specs: {'chip': 'M2', 'display': '10.9" Retina', 'pencil': 'Apple Pencil Pro'},
      ),
    ];
  }
}
