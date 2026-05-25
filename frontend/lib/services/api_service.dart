import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000"; // Android emulator

  // LOGIN
  static Future<bool> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {
        "email": email,
        "password": password,
      },
    );

    return res.statusCode == 200;
  }

  // GET PESP
  static Future<List<dynamic>> getPesp() async {
    final res = await http.get(Uri.parse("$baseUrl/pesp"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return [];
  }

  // CREATE PESP
  static Future<void> createPesp(Map<String, dynamic> data) async {
    await http.post(
      Uri.parse("$baseUrl/pesp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
  }
}