import 'dart:convert';
import 'package:http/http.dart' as http;


class ProductService {
  final String baseUrl = 'http://192.168.100.13:8080/products';
   Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
   }
}