import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  final String _baseUrl = dotenv.env['BASE_URL']!;

  Future<String?> signUp(String fullName, String email, String password, List<String> roles) async {
    final url = Uri.parse("$_baseUrl/auth/sign-up");

    final body = {
      "fullName": fullName,
      "email": email,
      "password": password,
      "roles": roles,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        return null; // Indica que la operación fue exitosa
      } else {
        // Parseamos el error enviado por el backend
        final responseBody = jsonDecode(response.body);
        return responseBody['message'] ?? "An unexpected error occurred";
      }
    } catch (e) {
      // Manejo de errores de conexión u otros problemas
      return "Failed to connect to the server. Please try again later.";
    }
  }
}
