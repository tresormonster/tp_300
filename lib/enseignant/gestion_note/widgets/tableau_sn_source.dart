import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TableauSNSource
    extends DataTableSource {

  final List<dynamic> anonymats;

  final Map<int, TextEditingController>
      notesControllers;

  final String recherche;

  TableauSNSource({

    required this.anonymats,

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
        anonymats[index];

    return DataRow(

      cells: [

        DataCell(

          surligner(

            e['code_anonymat'],
          ),
        ),

        DataCell(

          SizedBox(

            width: 100,

            child: TextField(

              controller:
                  notesControllers[
                      e['id_anonymat']],

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
      anonymats.length;

  @override
  int get selectedRowCount =>
      0;
}