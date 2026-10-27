import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Gün 2 & Gün 4: TextField, Padding, Container ve Filtreleme Mantığı
class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15, color: AppTheme.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search product...',
          hintStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 15),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20, color: AppTheme.textSecondary),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
