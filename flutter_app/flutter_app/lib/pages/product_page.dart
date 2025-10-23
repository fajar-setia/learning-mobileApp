import 'package:flutter/material.dart';
import 'package:flutter_app/components/bottom_nav.dart';
import '../services/product_service.dart';
import '../pages/page_product/product_detail_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductService _service = ProductService();
  late Future<List<dynamic>> _products;
  String _query = '';
  String _selectedCategory = '';
  int stock = 0;
  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    _products = _service.fetchProducts();
  }

  void _showFilterBottomState() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        String tempCategory = _selectedCategory; // temporary state

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Title
                  const Text(
                    'Filter Produk',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Category label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Filter Chips
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      _buildFilterChip(
                        label: 'Semua',
                        isSelected: tempCategory.isEmpty,
                        onSelected: () {
                          setModalState(() {
                            tempCategory = '';
                          });
                        },
                      ),
                      _buildFilterChip(
                        label: 'Makanan',
                        isSelected: tempCategory == 'makanan',
                        onSelected: () {
                          setModalState(() {
                            tempCategory = 'makanan';
                          });
                        },
                      ),
                      _buildFilterChip(
                        label: 'Aksesoris',
                        isSelected: tempCategory == 'aksesoris',
                        onSelected: () {
                          setModalState(() {
                            tempCategory = 'aksesoris';
                          });
                        },
                      ),
                      _buildFilterChip(
                        label: 'Obat',
                        isSelected: tempCategory == 'obat',
                        onSelected: () {
                          setModalState(() {
                            tempCategory = 'obat';
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Action Buttons
                  Row(
                    children: [
                      // Reset Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              tempCategory = '';
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: Colors.deepPurple),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Apply Button
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Tutup bottom sheet dengan animasi smooth
                            Navigator.pop(context);

                            // Delay untuk animasi bottom sheet selesai
                            await Future.delayed(
                              const Duration(milliseconds: 300),
                            );

                            // Update state di halaman utama
                            if (mounted) {
                              setState(() {
                                _selectedCategory = tempCategory;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Terapkan Filter',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Helper method untuk membuat FilterChip yang custom
  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelected(),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.deepPurple,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.deepPurple,
        checkmarkColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.deepPurple : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FloatingBottomNav()),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 0,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _query = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: _showFilterBottomState, //
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada produk'));
          }

          // 🔍 Filter pencarian
          final products = snapshot.data!
              .where(
                (p) =>
                    p['name'].toString().toLowerCase().contains(_query) ||
                    (p['tags'] as List).any(
                      (tag) => tag.toString().toLowerCase().contains(_query),
                    ),
              )
              .toList();

          if (products.isEmpty) {
            return const Center(child: Text('Produk tidak ditemukan'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 🔹 Dua kolom
                mainAxisSpacing: 5,
                crossAxisSpacing: 2,
                childAspectRatio: 0.68, // 🔹 Proporsi tinggi tiap kartu
              ),
              itemBuilder: (context, index) {
                final p = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: p),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar produk
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            p['images'] != null && p['images'].isNotEmpty
                                ? (p['images'][0].startsWith('http')
                                      ? p['images'][0]
                                      : "http://192.168.100.13:5000/${p['images'][0]}")
                                : 'https://via.placeholder.com/150',
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Nama dan harga
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p['name'] ?? 'Tanpa nama',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Rp.${p['price']}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (p['comparePrice'] != null)
                                        Text(
                                          'Rp.${p['comparePrice']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsetsGeometry.all(5.0),
                                    decoration: BoxDecoration(
                                      color:
                                          (p['isAvailable'] == true &&
                                              (p['stock'] ?? 0) > 0)
                                          ? Colors.green[100]
                                          : Colors.red[100],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      (p['isAvailable'] == true &&
                                              (p['stock'] ?? 0) > 0)
                                          ? 'Stok: ${p['stock']}'
                                          : 'Habis',
                                      style: TextStyle(
                                        color:
                                            (p['isAvailable'] == true &&
                                                (p['stock'] ?? 0) > 0)
                                            ? Colors.green[700]
                                            : Colors.red[700],
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber[700],
                                      size: 12,
                                    ),
                                    Text(
                                      '${p['rating']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                child: Text('${p['reviewCount']} Ulasan'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
