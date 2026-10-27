import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_state.dart';
import '../theme/app_theme.dart';

/// Gün 2 & Gün 4: ListTile, Card, Row, Column ve Sepet Satır Elemanı
class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // 1. Ürün Görseli Kutusu
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              product.localAssetPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.devices,
                    size: 32,
                    color: AppTheme.textSecondary,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 14),

          // 2. Ürün Bilgileri (İsim, Birim Fiyat)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // 3. Adet Kontrolleri (- 1 +)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 16),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    CartScope.of(context).updateQuantity(product.id, -1);
                  },
                ),
                Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 16),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    CartScope.of(context).updateQuantity(product.id, 1);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
