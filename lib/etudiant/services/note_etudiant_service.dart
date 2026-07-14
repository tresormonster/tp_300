// etudiant/services/note_etudiant_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../inscription/config_globale/constant/api_constant.dart';
import 'dart:typed_data';

class NoteEtudiantService {

  Future<List<dynamic>> chargerNotes(
    int idEtudiant,
  ) async {

    final response = await http.get(

      Uri.parse(
        "${ApiConstants.baseUrl}/note/etudiant/$idEtudiant",
      ),
    );

    if (response.statusCode == 200) {

      return jsonDecode(
        response.body,
      );
    }

    return [];
  }


  Future<Uint8List?> telechargerBulletin(
  int idEtudiant,
) async {

  final response = await http.get(

    Uri.parse(
      "${ApiConstants.baseUrl}/note/bulletin/$idEtudiant",
    ),
  );

  if (response.statusCode == 200) {

    return response.bodyBytes;
  }

  return null;
}



}