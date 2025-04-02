// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocify/data/shop.dart';
import 'package:grocify/model/product_model.dart';
import 'package:grocify/model/shop.dart';
import 'package:grocify/providers/admin_provider.dart';
import 'package:grocify/widgets/auth/alert_dialog.dart';
import 'package:grocify/widgets/product_details/product_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedCategory = 'All';
  List<ProductModel> _displayedProducts = [];
  final TextEditingController _searchController = TextEditingController();
  String _sortOption = 'Newest';

  @override
  void initState() {
    _getProducts();

    _searchController.addListener(() {
      _filterProducts();
    });
    super.initState();
  }

  Future<void> _getProducts() async {
    try {
      await context.read<AdminProvider>().getProducts();
      _displayedProducts = context.read<AdminProvider>().products;
      print('Products: ${_displayedProducts.map((p) => p.name).toList()}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching products: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    final allProducts = context.read<AdminProvider>().products;
    setState(() {
      if (query.isEmpty && _selectedCategory == 'All') {
        _displayedProducts = allProducts;
      } else if (query.isEmpty) {
        _displayedProducts =
            allProducts.where((p) => p.category == _selectedCategory).toList();
      } else if (_selectedCategory == 'All') {
        _displayedProducts =
            allProducts
                .where(
                  (p) =>
                      p.name.toLowerCase().contains(query) ||
                      p.category.toLowerCase().contains(query),
                )
                .toList();
      } else {
        _displayedProducts =
            allProducts.where((p) => p.category == _selectedCategory).toList();
      }

      // Apply sorting
      _sortProducts();
    });
  }

  void _sortProducts() {
    switch (_sortOption) {
      case 'Price: Low to High':
        _displayedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        _displayedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        _displayedProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
      default:
        // Assuming newest is the default order in ProductData
        break;
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterProducts();
    });
  }

  void _changeSort(String? value) {
    if (value != null) {
      setState(() {
        _sortOption = value;
        _sortProducts();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final categories = ['All', ...ProductData.getCategories()];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/Grocify.png',
          width: screenSize.width * 0.25,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController, // Connect controller
                      decoration: InputDecoration(
                        hintText: 'Search for groceries...',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 16),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.green,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: Icon(Icons.mic, color: Colors.white, size: 28),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/Mask Group.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Categories',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Categories horizontal list
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == _selectedCategory;

                      return GestureDetector(
                        onTap: () => _selectCategory(category),
                        child: Container(
                          margin: const EdgeInsets.only(right: 16, bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: GoogleFonts.poppins(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Sort and filter options
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedCategory == 'All'
                              ? 'All Products'
                              : _selectedCategory,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.green.shade50,
                        value: _sortOption,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.sort),
                        hint: Text('Sort by', style: GoogleFonts.poppins()),
                        items: [
                          DropdownMenuItem(
                            value: 'Newest',
                            child: Text('Newest', style: GoogleFonts.poppins()),
                          ),
                          DropdownMenuItem(
                            value: 'Price: Low to High',
                            child: Text(
                              'Price: Low to High',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Price: High to Low',
                            child: Text(
                              'Price: High to Low',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Rating',
                            child: Text('Rating', style: GoogleFonts.poppins()),
                          ),
                        ],
                        onChanged: _changeSort,
                      ),
                    ],
                  ),
                ),

                // Products count and clear filters
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_displayedProducts.length} products found',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      if (_searchController.text.isNotEmpty ||
                          _selectedCategory != 'All')
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {
                              _selectedCategory = 'All';
                              _displayedProducts =
                                  context
                                      .read<AdminProvider>()
                                      .products; // Reset to all products
                            });
                          },
                          child: Text(
                            'Clear filters',
                            style: GoogleFonts.poppins(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                if (!context.watch<AdminProvider>().isLoading)
                  // Product grid
                  _displayedProducts.isEmpty
                      ? _buildNoProductsFound()
                      : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: _displayedProducts.length,
                        itemBuilder: (context, index) {
                          final product = _displayedProducts[index];
                          return ProductCard(product: product);
                        },
                      ),

                if (context.watch<AdminProvider>().isLoading)
                  Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildProductCard(ProductModel product) {
    return ProductCard(product: product);
  }

  Widget _buildNoProductsFound() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try different keywords or categories',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
