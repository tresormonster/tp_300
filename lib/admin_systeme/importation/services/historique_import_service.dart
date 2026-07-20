import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../inscription/config_globale/constant/api_constant.dart';
import '../models/import_historique.dart';

class HistoriqueImportService {
  Future<List<ImportHistorique>> getHistorique() async {
    final response = await http.get(
      Uri.parse(
        "${ApiConstants.baseUrl}/admin/import-etudiants",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Impossible de charger l'historique.");
    }

    final List data = jsonDecode(response.body);

    return data
        .map(
          (e) => ImportHistorique.fromJson(e),
        )
        .toList();
  }

  Future<void> supprimerImport(int id) async {
    final response = await http.delete(
      Uri.parse(
        "${ApiConstants.baseUrl}/admin/import-etudiants/$id",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Suppression impossible.");
    }
  }
}