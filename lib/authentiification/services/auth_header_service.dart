import 'token_service.dart';

class AuthHeaderService {

  // 🔥 GET AUTH HEADERS
  static Future<Map<String, String>>
      getAuthHeaders() async {

    final token =
        await TokenService.getToken();

    return {

      "Content-Type":
          "application/json",

      "Authorization":
          "Bearer $token",
    };
  }
}