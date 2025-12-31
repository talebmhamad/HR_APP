import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.101:53612/api/users";

  static Future<bool> login(String email, String password) async {
    /*
    try {
      final url = Uri.parse('$baseUrl/login');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return true; // LOGIN SUCCESS
      } else {
        return false; // LOGIN FAILED
      }
    } catch (e) {
      return false;
    }
*/
    return true;
  }
}
