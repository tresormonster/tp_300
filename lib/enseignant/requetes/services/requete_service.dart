import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../inscription/config_globale/constant/api_constant.dart';

class RequeteService {

  Future<List<dynamic>> chargerRequetes(
    int idEnseignant,
  ) async {

    final response =
        await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/requete/enseignant/$idEnseignant",
      ),
    );

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );
    }

    return [];
  }






  Future<bool> repondreRequete({
  required int idRequete,
  required String reponse,
  required String statut,
}) async {

  final response = await http.patch(

    Uri.parse(
      "${ApiConstants.baseUrl}/requete/repondre/$idRequete",
    ),

    headers: {
      "Content-Type": "application/json",
    },

    body: jsonEncode({

      "reponse": reponse,

      "statut": statut,
    }),
  );

  return response.statusCode == 200;
}
}