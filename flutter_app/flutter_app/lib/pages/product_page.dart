import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _products = _service.fetchProducts();
  }

  void _showFilterBottomState() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(20))
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filter Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 🔹 Contoh kategori (sesuaikan dengan data kamu)
                  Wrap(
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        label: const Text('Semua'),
                        selected: _selectedCategory.isEmpty,
                        onSelected: (selected) {
                          setModalState(() => _selectedCategory = '');
                        },
                      ),
                      FilterChip(
                        label: const Text('Makanan'),
                        selected: _selectedCategory == 'makanan',
                        onSelected: (selected) {
                          setModalState(() =>
                              _selectedCategory = selected ? 'makanan' : '');
                        },
                      ),
                      FilterChip(
                        label: const Text('Aksesoris'),
                        selected: _selectedCategory == 'aksesoris',
                        onSelected: (selected) {
                          setModalState(() =>
                              _selectedCategory = selected ? 'aksesoris' : '');
                        },
                      ),
                      FilterChip(
                        label: const Text('Obat'),
                        selected: _selectedCategory == 'obat',
                        onSelected: (selected) {
                          setModalState(
                              () => _selectedCategory = selected ? 'obat' : '');
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 🔘 Tombol Terapkan
                  ElevatedButton(
                    onPressed: () {
                      setState(() {}); // refresh tampilan utama
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Terapkan Filter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
              onPressed: _showFilterBottomState, // 🔹 panggil fungsi filter
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
                        // 🖼️ Gambar produk
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

                        // 🧾 Nama dan harga
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
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),

                              const SizedBox(height: 6),
                              // 🏷️ Tags (maksimal 2 biar tidak kepanjangan)
                              Wrap(
                                spacing: 4.0,
                                runSpacing: 2.0,
                                children: (p['tags'] as List)
                                    .take(2) // batasi 2 tag saja agar rapi
                                    .map(
                                      (tag) => Chip(
                                        label: Text(
                                          tag.toString(),
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        backgroundColor: Colors.amber.shade100,
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    )
                                    .toList(),
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
