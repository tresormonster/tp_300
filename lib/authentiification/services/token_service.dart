import 'package:shared_preferences/shared_preferences.dart';

class TokenService {

  static const _tokenKey =
      "jwt_token";


      static const _roleKey =
    "role";

static const _idKey =
    "user_id";

  // 🔥 SAVE TOKEN
  static Future<void> saveToken(
    String token,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      _tokenKey,
      token,
    );
  }

  // 🔥 GET TOKEN
  static Future<String?> getToken() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      _tokenKey,
    );
  }

  // 🔥 REMOVE TOKEN
  static Future<void> removeToken() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.remove(
      _tokenKey,
    );
  }



  // 🔥 SAVE ROLE
static Future<void> saveRole(
  String role,
) async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.setString(
    _roleKey,
    role,
  );
}

// 🔥 GET ROLE
static Future<String?> getRole() async {

  final prefs =
      await SharedPreferences
          .getInstance();

  return prefs.getString(
    _roleKey,
  );
}

// 🔥 SAVE ID
static Future<void> saveId(
  int id,
) async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.setInt(
    _idKey,
    id,
  );
}

// 🔥 GET ID
static Future<int?> getId() async {

  final prefs =
      await SharedPreferences
          .getInstance();

  return prefs.getInt(
    _idKey,
  );
}

// 🔥 REMOVE ROLE
static Future<void> removeRole() async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.remove(
    _roleKey,
  );
}

// 🔥 REMOVE ID
static Future<void> removeId() async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.remove(
    _idKey,
  );
}

// 🔥 CLEAR SESSION
static Future<void> clearSession() async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.remove(_tokenKey);
  await prefs.remove(_roleKey);
  await prefs.remove(_idKey);
}
}
