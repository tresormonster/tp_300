import 'dart:convert';

import 'package:http/http.dart'
    as http;

import '../../inscription/config_globale/constant/api_constant.dart';

import 'token_service.dart';

class AuthService {

  // 🔥 LOGIN
 static Future<Map<String, dynamic>?> login(

  String email,

  String password,
) async {

  final response =
      await http.post(

    Uri.parse(
      "${ApiConstants.baseUrl}/auth/login",
    ),

    headers: {
      "Content-Type":
          "application/json",
    },

    body: jsonEncode({

      "email": email,

      "mot_de_passe": password,
    }),
  );

  if (response.statusCode == 200 ||
      response.statusCode == 201) {

    final data =
        jsonDecode(response.body);

    await TokenService.saveToken(

      data["access_token"],
    );


    await TokenService.saveRole(
  data["role"],
);

await TokenService.saveId(
  data["id"],
);

    return data;
  }

  return null;
}
}