import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes/inscription/config_globale/constant/api_constant.dart';

class ImportResult {
  final bool success;
  final String message;

  ImportResult({
    required this.success,
    required this.message,
  });
}

class ImportService {
  Future<ImportResult> importExcel(
    List<int> bytes,
    String fileName,
    String cycle,
    String filiere,
    String niveau,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${ApiConstants.baseUrl}/admin/import-etudiants"),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: fileName,
        ),
      );

      request.fields['cycle'] = cycle;
      request.fields['filiere'] = filiere;
      request.fields['niveau'] = niveau;

      final response = await request.send();

      final body = await response.stream.bytesToString();

      print("STATUS = ${response.statusCode}");
      print("BODY = $body");

      Map<String, dynamic> json = {};

      if (body.isNotEmpty) {
        json = jsonDecode(body);
      }

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return ImportResult(
          success: true,
          message: json["message"] ?? "Importation terminée.",
        );
      }

      return ImportResult(
        success: false,
        message: json["message"] ?? "Une erreur est survenue.",
      );
    } catch (e) {
      return ImportResult(
        success: false,
        message: "Impossible de contacter le serveur.",
        
      );
    }
  }
}