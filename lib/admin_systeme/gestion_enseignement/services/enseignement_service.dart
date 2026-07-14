import 'dart:convert';

import 'package:http/http.dart'
    as http;

import 'package:notes/inscription/config_globale/constant/api_constant.dart';

import '../models/enseignement_model.dart';

class EnseignementService {

  Future<List<EnseignementModel>>
      getAll() async {

    final response =
        await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/enseignements",
      ),
    );

    final data =
        jsonDecode(
      response.body,
    );

    return (data as List)

        .map(
          (e) =>
              EnseignementModel
                  .fromJson(e),
        )
        .toList();
  }

  Future<bool> create(
    EnseignementModel ens,
  ) async {

    final response =
        await http.post(

      Uri.parse(
        "${ApiConstants.baseUrl}/enseignements",
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
        "${ApiConstants.baseUrl}/enseignements/$id",
      ),
    );

    return response.statusCode ==
            200 ||
        response.statusCode ==
            204;
  }


  Future<bool> update(
  int id,
  EnseignementModel ens,
) async {

  final response =
      await http.patch(

    Uri.parse(
      "${ApiConstants.baseUrl}/enseignements/$id",
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