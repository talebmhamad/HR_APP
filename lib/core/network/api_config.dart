class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:5268';

  static Map<String, String> headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
