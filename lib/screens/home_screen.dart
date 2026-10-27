import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../routes/app_routes.dart';
import '../state/cart_state.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_card.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/product_card.dart';

/// Gün 1, Gün 4, Gün 5: StatefulWidget Mantığı, Listeleme, GridView ve Arama/Filtreleme
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = 'All';
  bool _isLoading = true;

  final List<String> _categories = ['All', 'Audio', 'iPhone', 'Mac', 'iPad', 'Watch'];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Gün 4: JSON'dan Veri Yükleme ve Dinamik Liste Oluşturma
  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    final products = await ProductDataService.loadProductsFromAsset();
    if (mounted) {
      setState(() {
        _allProducts = products;
        _applyFilters();
        _isLoading = false;
      });
    }
  }

  /// Gün 4: Arama ve Filtreleme Mantığı
  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final matchesQuery = query.isEmpty ||
            product.name.toLowerCase().contains(query) ||
            product.tagline.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query);

        final matchesCategory = _selectedCategory == 'All' || product.category == _selectedCategory;

        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Discover',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Find your perfect device',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
        actions: [
          // Sepet Simgesi ve Adet Rozeti (Cart Badge)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, size: 28),
                  onPressed: () {
                    // Gün 3: Sayfa Geçişi (Named Route)
                    Navigator.pushNamed(context, AppRoutes.cart);
                  },
                ),
                if (cartState.totalCount > 0)
                  Positioned(
                    right: 6,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppTheme.accentOrange,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${cartState.totalCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // 1. Arama Çubuğu (Gün 4)
                SliverToBoxAdapter(
                  child: CustomSearchBar(
                    controller: _searchController,
                    onChanged: (_) => _applyFilters(),
                    onClear: () {
                      _searchController.clear();
                      _applyFilters();
                    },
                  ),
                ),

                // 2. Özel Kampanya Banner'ı (Gün 2)
                const SliverToBoxAdapter(
                  child: BannerCard(),
                ),

                // 3. Kategori Filtre Çipleri
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = category == _selectedCategory;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedCategory = category;
                                  _applyFilters();
                                });
                              }
                            },
                            selectedColor: AppTheme.textPrimary,
                            backgroundColor: AppTheme.cardColor,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : AppTheme.textPrimary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide.none,
                            ),
                            showCheckmark: false,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // 4. Ürün Listesi Başlığı
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Featured Products',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          '${_filteredProducts.length} items',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 5. GridView ile Ürün Kartları (Gün 5)
                if (_filteredProducts.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 64, color: AppTheme.textSecondary),
                          SizedBox(height: 12),
                          Text(
                            'No products found',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Try adjusting your search or category filter',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = _filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              // Gün 3: Sayfalar Arasi Veri Tasima (Route Arguments)
                              Navigator.pushNamed(
                                context,
                                AppRoutes.detail,
                                arguments: product,
                              );
                            },
                          );
                        },
                        childCount: _filteredProducts.length,
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 32),
                ),
              ],
            ),
    );
  }
}
