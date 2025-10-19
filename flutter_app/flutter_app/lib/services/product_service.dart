import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  // Ganti IP dengan IP laptop kamu
  final String baseUrl = 'http://192.168.100.13:5000/api/products';

  Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // Coba deteksi apakah hasilnya List atau Map
        if (body is List) {
          return body;
        } else if (body is Map && body.containsKey('data')) {
          return body['data'];
        } else {
          throw Exception('Format data tidak dikenali: $body');
        }
      } else {
        throw Exception('Gagal memuat produk (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Gagal mengambil data produk: $e');
    }
  }
}
