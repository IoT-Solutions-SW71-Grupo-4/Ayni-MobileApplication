import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SignInService {
  final String baseUrl = 'http://10.0.2.2:8080/api/v1/auth';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Guardar el token y el ID en storage
      await _storage.write(key: 'token', value: data['token']);
      await _storage.write(key: 'id', value: data['id'].toString());
      return true;
    } else {
      return false;
    }
  }
}
