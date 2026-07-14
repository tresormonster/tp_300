import 'dart:convert';

import 'package:http/http.dart'
    as http;

import 'package:notes/inscription/config_globale/constant/api_constant.dart';

import '../models/filiere_model.dart';
import '../models/niveau_model.dart';
import '../models/ue_model.dart';

class UeService {

  // 🔥 FILIERES
  Future<List<FiliereModel>>
      getFilieres() async {

    final response =
        await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/filiere",
      ),
    );

    final data =
        jsonDecode(
      response.body,
    );

    return (data as List)

        .map(

          (e) =>
              FiliereModel
                  .fromJson(e),
        )

        .toList();
  }

  // 🔥 NIVEAUX
  Future<List<NiveauModel>>
      getNiveauxByFiliere(
    int idFiliere,
  ) async {

    final response =
        await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/niveaux/filiere/$idFiliere",
      ),
    );

    final data =
        jsonDecode(
      response.body,
    );

    return (data as List)

        .map(

          (e) =>
              NiveauModel
                  .fromJson(e),
        )

        .toList();
  }

  // 🔥 UE
  Future<List<UeModel>>
      getAllUes() async {

    final response =
        await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/ue",
      ),
    );

    final data =
        jsonDecode(
      response.body,
    );

    return (data as List)

        .map(

          (e) =>
              UeModel
                  .fromJson(e),
        )

        .toList();
  }

  // 🔥 CREATE
  Future<bool> createUe(
    UeModel ue,
  ) async {

    final response =
        await http.post(

      Uri.parse(
        "${ApiConstants.baseUrl}/ue",
      ),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode(
        ue.toJson(),
      ),
    );

    return response.statusCode ==
            201 ||
        response.statusCode ==
            200;
  }

  // 🔥 DELETE
  Future<bool> deleteUe(
    int id,
  ) async {

    final response =
        await http.delete(

      Uri.parse(
        "${ApiConstants.baseUrl}/ue/$id",
      ),
    );

    return response.statusCode ==
            200 ||
        response.statusCode ==
            204;
  }



  Future<List<UeModel>>
    getMesUes(
  int idEnseignant,
) async {

  final response =
      await http.get(

    Uri.parse(

      "${ApiConstants.baseUrl}/enseignements/enseignant/$idEnseignant",
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
}