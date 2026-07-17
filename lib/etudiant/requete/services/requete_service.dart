import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../../inscription/config_globale/constant/api_constant.dart';

class RequeteService {
  Future<List<dynamic>> chargerRequetes(int idEtudiant) async {
    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/requete/etudiant/$idEtudiant"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

  Future<List<String>> uploadPiecesJointes(List<PlatformFile> fichiers) async {
    print("UPLOAD DEBUT");

    final request = http.MultipartRequest(
      'POST',

      Uri.parse("${ApiConstants.baseUrl}/requete/upload"),
    );

    for (final fichier in fichiers) {
      print("Ajout : ${fichier.name}");

      request.files.add(
        http.MultipartFile.fromBytes(
          'files',

          fichier.bytes!,

          filename: fichier.name,
        ),
      );
    }

    print("ENVOI SERVEUR");

    final response = await request.send();

    print("UPLOAD TERMINE");
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = await response.stream.bytesToString();

      print(body);

      return List<String>.from(jsonDecode(body));
    }

    return [];
  }

  Future<bool> creerRequete({
    required int idEtudiant,

    required int idUe,

    required String objet,

    required String message,
    required List<PlatformFile> piecesJointes,
  }) async {
    print("CREATION REQUETE");

    final urls = await uploadPiecesJointes(piecesJointes);

    print("URLS RECUES : $urls");

    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/requete"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "id_etudiant": idEtudiant,

        "id_ue": idUe,

        "objet": objet,

        "message": message,

        "pieces_jointes": urls,
      }),
    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<dynamic>> chargerUeContestables(int idEtudiant) async {
    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/note/etudiant/$idEtudiant"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

 Future<bool> modifierRequete({

  required int idRequete,

  required String objet,

  required String message,

  required List<String> piecesJointes,
}) async {

  final response = await http.patch(

    Uri.parse(
      "${ApiConstants.baseUrl}/requete/$idRequete",
    ),

    headers: {
      "Content-Type":
          "application/json",
    },

    body: jsonEncode({

      "objet": objet,

      "message": message,

      "pieces_jointes":
          piecesJointes,
    }),
  );

  return response.statusCode == 200;
}

  Future<bool> supprimerRequete(int idRequete) async {
    final response = await http.delete(
      Uri.parse("${ApiConstants.baseUrl}/requete/$idRequete"),
    );

    return response.statusCode == 200;
  }
}
