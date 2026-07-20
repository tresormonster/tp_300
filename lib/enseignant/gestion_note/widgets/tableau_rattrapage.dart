import 'package:flutter/material.dart';

import '../controllers/note_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'tableau_rattrapage_source.dart';

class TableauRattrapage
    extends StatefulWidget {

  final int idUe;
  final bool hasTp;

  const TableauRattrapage({

    super.key,

    required this.idUe,
    required this.hasTp,

  });

  @override
  State<TableauRattrapage>
      createState() =>
          _TableauRattrapageState();
}

class _TableauRattrapageState
    extends State<TableauRattrapage> {

  final controller =
      NoteController();

  List<dynamic> anonymats = [];

  bool loading = true;

  final Map<int, TextEditingController>
      notesControllers = {};

  @override
  void initState() {

    super.initState();

    charger();
  }


@override
void didUpdateWidget(covariant TableauRattrapage oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.idUe != widget.idUe) {
    notesControllers.clear();

    anonymats.clear();

    loading = true;

    charger();
  }
}


  Future<void> publier() async {

  final ok =
      await controller.publierUe(
    widget.idUe,
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context)
      .showSnackBar(

    SnackBar(

      content: Text(

        ok
            ? "Notes publiées"
            : "Erreur publication",
      ),
    ),
  );
}

  Future<void> charger() async {

  notesControllers.clear();

  final data =
      await controller.chargerRattrapage(
    widget.idUe,
  );

  for (final e in data) {

    notesControllers[e['id_anonymat']] =
        TextEditingController(
      text: e['note_sn']?.toString() ?? "",
    );
  }

  if (!mounted) return;

  setState(() {
    anonymats = data;
    loading = false;
  });
}

  Future<void> enregistrer() async {

    final List<Map<String, dynamic>>
        notes = [];

    for (final e in anonymats) {




final texte =
    notesControllers[
            e['id_anonymat']]
        ?.text
        .trim() ??
    "";

if (texte.isNotEmpty) {

  final note =
      double.parse(texte);
final maxNote =

    widget.hasTp

        ? 40

        : 70;

if (note < 0 || note > maxNote) {

  ScaffoldMessenger.of(context)
      .showSnackBar(

    SnackBar(

      content: Text(

        "La note doit être comprise entre 0 et $maxNote",
      ),
    ),
  );

  return;
}
}




      notes.add({

        "id_anonymat":
            e['id_anonymat'],

        "note_sn":
    notesControllers[
            e['id_anonymat']]
        ?.text
        .trim()
        .isEmpty ?? true

        ? null

        : double.parse(
            notesControllers[
                    e['id_anonymat']]
                !.text,
          ),
      });
    }

    final ok =
        await controller
            .enregistrerRattrapage(
      notes,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(

          ok

              ? "Notes rattrapage enregistrées"

              : "Erreur",
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    if (loading) {

      return const Center(

        child:
            CircularProgressIndicator(),
      );
    }

    return Column(

      children: [

       Row(

  children: [

    ElevatedButton.icon(

      onPressed: enregistrer,

      icon: const Icon(
        Icons.save,
      ),

      label: const Text(
        "Enregistrer",
      ),
    ),

    const SizedBox(
      width: 10,
    ),

    ElevatedButton.icon(

      onPressed: publier,

      icon: const Icon(
        Icons.publish,
      ),

      label: const Text(
        "Publier",
      ),
    ),
  ],
),
        const SizedBox(
          height: 20,
        ),

        Container(

          color:
              Colors.red.shade100,

          padding:
              const EdgeInsets.all(
            10,
          ),

          child: const Row(

            children: [

              Expanded(

                flex: 2,

                child: Text(

                  "Code",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Expanded(

                child: Text(

                  "Rattrapage",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
  child: PaginatedDataTable2(

    rowsPerPage: 150,

    source:
        TableauRattrapageSource(

      anonymats: anonymats,

      notesControllers:
          notesControllers,

      recherche: "",
    ),

    columns:  [

      DataColumn(
        label: Text(
          "Code",
        ),
      ),

      DataColumn(
        label: Text(
          widget.hasTp
    ? "Rattrapage (/40)"
    : "Rattrapage (/70)"
        ),
      ),
    ],
  ),
),
      ],
    );
  }
}