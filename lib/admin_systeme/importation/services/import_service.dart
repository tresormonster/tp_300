import 'package:http/http.dart' as http;

import 'package:notes/inscription/config_globale/constant/api_constant.dart';

class ImportService {

  Future<bool> importExcel(

    List<int> bytes,

    String fileName,

    String cycle,

    String filiere,

    String niveau,

  ) async {

    try {

      var request = http.MultipartRequest(

        'POST',

        Uri.parse(
          "${ApiConstants.baseUrl}/admin/import-etudiants",
        ),
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

      final response =
          await request.send();

      print(
        "STATUS : ${response.statusCode}",
      );

      return response.statusCode == 200 ||

          response.statusCode == 201;
    }

    catch (e) {

      print(e);

      return false;
    }
  }
}