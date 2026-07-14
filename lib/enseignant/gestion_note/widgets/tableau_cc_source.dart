import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TableauCCSource
    extends DataTableSource {

  final List<dynamic> etudiants;

  final Map<int, TextEditingController>
      notesControllers;

  final String recherche;

  TableauCCSource({

    required this.etudiants,

    required this.notesControllers,

    required this.recherche,
  });






Widget surligner(String texte) {

  if (recherche.isEmpty) {

    return Text(texte);
  }

  if (!texte
      .toLowerCase()
      .contains(
        recherche.toLowerCase(),
      )) {

    return Text(texte);
  }

  return Container(

    color: Colors.yellow,

    padding:
        const EdgeInsets.symmetric(
      horizontal: 4,
    ),

    child: Text(

      texte,

      style: const TextStyle(

        fontWeight:
            FontWeight.bold,
      ),
    ),
  );
}





  @override
  DataRow getRow(
    int index,
  ) {

    final e =
        etudiants[index];

    return DataRow(

      cells: [

       DataCell(
  surligner(
    e['matricule'],
  ),
),

        DataCell(
  surligner(
    e['nom'],
  ),
),

        DataCell(
  surligner(
    e['prenom'],
  ),
),

        DataCell(

          SizedBox(

            width: 80,

            child: TextField(

              controller:
                  notesControllers[
                      e['id_etudiant']],

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(

                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate =>
      false;

  @override
  int get rowCount =>
      etudiants.length;

  @override
  int get selectedRowCount => 0;
}