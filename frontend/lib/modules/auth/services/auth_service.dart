import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  /// L’URL de ton auth-service Nest.
  /// Sur Android emulator : remplace 'localhost' par '10.0.2.2'
  final String baseUrl;

  AuthService({ this.baseUrl = 'http://localhost:3001' });

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required DateTime date_naissance,
    required String sexe,              // "M" ou "F"
    required String telephone,
    required String adresse,
    required String piece_identite,
    bool      isVerified = false,
    String?   role,
  }) async {
     final uri = Uri.parse('$baseUrl/register');
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'date_naissance': date_naissance.toIso8601String()+ 'Z',
      'sexe': sexe,
      'telephone': telephone,
      'adresse': adresse,
      'piece_identite': piece_identite,
      'isVerified': isVerified,
      'role': role,
    });

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (res.statusCode != 201 && res.statusCode != 200) {
      final Map<String, dynamic> err = jsonDecode(res.body);
      final message = err['message'] ?? res.reasonPhrase;
      throw Exception('Registration failed (${res.statusCode}): $message');
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$baseUrl/login');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (res.statusCode != 200) {
      final Map<String, dynamic> err = jsonDecode(res.body);
      final message = err['message'] ?? res.reasonPhrase;
      throw Exception('Login failed (${res.statusCode}): $message');
    }

    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
