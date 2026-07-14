import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:notes/inscription/config_globale/constant/api_constant.dart';

import '../models/anonymat_model.dart';

class AnonymatService {

  Future<List<AnonymatModel>> getAnonymats(
    int idUe,
    bool rattrapage,
  ) async {

    final response = await http.get(

      Uri.parse(

        "${ApiConstants.baseUrl}/anonymat/ue/$idUe/$rattrapage",
      ),
    );

    final data = jsonDecode(response.body);

    return (data as List)

        .map(
          (e) => AnonymatModel.fromJson(e),
        )

        .toList();
  }

  Future<bool> generer(
    int idUe,
    bool rattrapage,
  ) async {

    final url =

        rattrapage

            ? "${ApiConstants.baseUrl}/anonymat/generer-rattrapage/$idUe"

            : "${ApiConstants.baseUrl}/anonymat/generer/$idUe";

    final response =

        await http.post(Uri.parse(url));

    return response.statusCode == 200 ||
        response.statusCode == 201;
  }



  Future<bool> supprimer(

  int idUe,

  bool rattrapage,

) async {

  final response =
      await http.delete(

    Uri.parse(

      "${ApiConstants.baseUrl}/anonymat/ue/$idUe/$rattrapage",
    ),
  );

  return response.statusCode == 200;
}
}