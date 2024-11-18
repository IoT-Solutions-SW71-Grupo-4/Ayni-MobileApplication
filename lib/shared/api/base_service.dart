import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class BaseService {
  final String baseUrl = 'http://10.0.2.2:8080/api/v1';
  final _storage = const FlutterSecureStorage();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.read(key: 'token');
    if (token == null) throw Exception('No token found');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String endpoint) async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(Uri.parse('$baseUrl/$endpoint'),
        headers: headers, body: jsonEncode(data));
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.put(Uri.parse('$baseUrl/$endpoint'),
        headers: headers, body: jsonEncode(data));
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final headers = await _getHeaders();
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'), headers: headers);
    return _handleResponse(response);
  }

  // metodo para subir foto
  Future<dynamic> uploadFile(
      String endpoint, String fieldName, String filePath,
      {String method = 'POST'}) async {
    final headers = await _getHeaders(); // Obtener headers con token
    final uri = Uri.parse('$baseUrl/$endpoint');

    final request = http.MultipartRequest(method, uri); // Usamos el método dinámico
    request.headers.addAll(headers);

    // Agregar el archivo
    final file = await http.MultipartFile.fromPath(fieldName, filePath);
    request.files.add(file);

    // Ejecutar la solicitud
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(responseBody);
    } else {
      throw Exception('HTTP Error: ${response.statusCode}, ${responseBody}');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('HTTP Error: ${response.statusCode}, ${response.body}');
    }
  }
}
