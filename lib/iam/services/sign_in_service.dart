import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInService {
  final String _baseUrl = dotenv.env['BASE_URL']!;
  final _storage = const FlutterSecureStorage();

  Future<bool> signIn(String email, String password) async {
    final url = Uri.parse("$_baseUrl/auth/sign-in");
    http://localhost:8080/api/v1/auth/sign-in


    final body = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Store the token securely
        final data = jsonDecode(response.body);
        await _storage.write(key: "auth_token", value: data["token"]);
        return true;
      } else {
        print("Sign-in failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error during sign-in: $e");
      return false;
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: "auth_token");
  }
}
