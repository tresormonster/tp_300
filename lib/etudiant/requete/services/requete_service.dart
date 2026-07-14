import 'dart:convert';

import 'package:http/http.dart'
    as http;


import '../models/ue_model.dart';

import '../models/requete_model.dart';
import 'package:notes/inscription/config_globale/constant/api_constant.dart';

class RequeteService {

  Future<List<UeModel>>
      getUesByNiveau(
    int idNiveau,
  ) async {

    final response =
        await http.get(

      Uri.parse(

        "${ApiConstants.baseUrl}/ue/niveau/$idNiveau",
      ),
    );

    final data =
        jsonDecode(
      response.body,
    );

    return (data as List)

        .map(

          (e) =>
              UeModel.fromJson(
            e,
          ),
        )

        .toList();
  }

  Future<bool>
      envoyerRequete(
    RequeteModel requete,
  ) async {

    final response =
        await http.post(

      Uri.parse(

        "${ApiConstants.baseUrl}/requetes",
      ),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode(

        requete.toJson(),
      ),
    );

    return response.statusCode ==
            201 ||
        response.statusCode ==
            200;
  }
}