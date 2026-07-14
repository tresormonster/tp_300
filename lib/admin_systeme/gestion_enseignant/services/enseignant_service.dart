import 'dart:convert';

import 'package:http/http.dart'
    as http;

import 'package:notes/inscription/config_globale/constant/api_constant.dart';

import '../models/enseignant_model.dart';

class EnseignantService {

  Future<List<EnseignantModel>>
      getAll() async {

    final response =
        await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/enseignant",
      ),
    );

    final data =
        jsonDecode(
      response.body,
    );

    return (data as List)

        .map(

          (e) =>
              EnseignantModel
                  .fromJson(e),
        )

        .toList();
  }

  Future<bool> create(
    EnseignantModel ens,
  ) async {

    final response =
        await http.post(

      Uri.parse(
        "${ApiConstants.baseUrl}/enseignant",
      ),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode(
        ens.toJson(),
      ),
    );

    return response.statusCode ==
            201 ||
        response.statusCode ==
            200;
  }

  Future<bool> delete(
    int id,
  ) async {

    final response =
        await http.delete(

      Uri.parse(
        "${ApiConstants.baseUrl}/enseignant/$id",
      ),
    );

    return response.statusCode ==
            200 ||
        response.statusCode ==
            204;
  }



  Future<bool> update(
  int id,
  EnseignantModel ens,
) async {

  final response =
      await http.patch(

    Uri.parse(
      "${ApiConstants.baseUrl}/enseignant/$id",
    ),

    headers: {

      "Content-Type":
          "application/json",
    },

    body: jsonEncode(
      ens.toJson(),
    ),
  );

  return response.statusCode ==
          200 ||
      response.statusCode ==
          204;
}
}