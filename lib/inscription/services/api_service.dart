import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config_globale/constant/api_constant.dart';

import '../models/etudiant.dart';

import 'ia_api_service.dart';

class ApiService implements IApiService {

  @override
  Future<bool> register(
    Etudiant etudiant,
  ) async {

    final res = await http.post(

      Uri.parse(
        "${ApiConstants.baseUrl}/etudiants/activation",
      ),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode(
        etudiant.toJson(),
      ),
    );

    return res.statusCode == 200 ||

        res.statusCode == 201;
  }

  @override
  Future<List> getFilieres() async {

    final res = await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/filiere",
      ),
    );

    final data =
        jsonDecode(res.body);

    return data is List

        ? data

        : data["data"] ?? [];
  }

  @override
  Future<List> getNiveaux() async {

    final res = await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/niveaux",
      ),
    );

    final data =
        jsonDecode(res.body);

    return data is List

        ? data

        : data["data"] ?? [];
  }
}