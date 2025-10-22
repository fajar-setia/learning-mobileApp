import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const String _BASE_API_LOGIN = 'http://192.168.100.13:5000/api/users';

class AuthApiServiceLogin {
  static Future<Map<String,dynamic>?> login (String username, String password)async{
    final loginEndpoint = Uri.parse('$_BASE_API_LOGIN/login');

    try {
      final response = await http.post(
        loginEndpoint,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username':username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final responData = json.decode(response.body);
        return {
          'token': responData['token'],
          'username':responData['user']['username']
      };

      }else{
        final errorData = json.decode(response.body);
        print('Login API Gagal: ${errorData['message']}');
        return null;
      }
    }catch (e) {
      print('Login API Error Koneksi: $e');
      return null;
    }
  }
}