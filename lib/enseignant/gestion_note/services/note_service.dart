import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../inscription/config_globale/constant/api_constant.dart';

class NoteService {
  Future<List<dynamic>> chargerCC(int idUe) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/note/cc/$idUe'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

  Future<List<dynamic>> chargerTP(int idUe) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/note/tp/$idUe'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

  Future<bool> enregistrerCC(List<Map<String, dynamic>> notes) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/note/cc'),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(notes),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<bool> enregistrerTP(List<Map<String, dynamic>> notes) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/note/tp'),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(notes),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<bool> publierUe(int idUe) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/note/publier-ue/$idUe'),
    );

    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.body}");

    return response.statusCode == 200||
         response.statusCode == 201;
  }

  Future<List<dynamic>> chargerSN(int idUe) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/note/sn/$idUe'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

  Future<bool> enregistrerSN(List<Map<String, dynamic>> notes) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/note/sn'),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(notes),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<List<dynamic>> chargerRattrapage(int idUe) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/note/rattrapage/$idUe'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

  Future<bool> enregistrerRattrapage(List<Map<String, dynamic>> notes) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/note/rattrapage'),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(notes),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
