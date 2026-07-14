import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/anonymat_model.dart';

class AnonymatPdf {

  static Future<void> imprimer({

    required String ue,

    required String session,

    required List<AnonymatModel> anonymats,

  }) async {

    final pdf = pw.Document();

    pdf.addPage(

      pw.MultiPage(

        maxPages: 500,

        build: (context) => [

          pw.Text(

            "Université de Yaoundé I",

            style: pw.TextStyle(

              fontSize: 20,

              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Text(

            "LISTE DES ANONYMATS",

            style: pw.TextStyle(

              fontSize: 18,

              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 20),

          pw.Text(
            "UE : $ue",
          ),

          pw.Text(
            "Session : $session",
          ),

          pw.SizedBox(height: 20),

          pw.Table.fromTextArray(

            headers: const [

              "Code",

              "Matricule",

              "Nom",

              "Prénom",
            ],

            data: anonymats.map(

              (e) => [

                e.codeAnonymat,

                e.matricule,

                e.nom,

                e.prenom,
              ],

            ).toList(),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(

      onLayout: (format) async {

        return pdf.save();
      },
    );
  }
}