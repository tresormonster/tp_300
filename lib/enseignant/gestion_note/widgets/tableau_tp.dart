import 'package:flutter/material.dart';

import '../controllers/note_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'tableau_tp_source.dart';

class TableauTP extends StatefulWidget {

  final int idUe;

  const TableauTP({

    super.key,

    required this.idUe,
  });

  @override
  State<TableauTP> createState() =>
      _TableauTPState();
}

class _TableauTPState
    extends State<TableauTP> {

  final controller =
      NoteController();

  final rechercheController =
      TextEditingController();

  List<dynamic> etudiants = [];

  List<dynamic> etudiantsFiltres = [];

  bool loading = true;

  Map<int, TextEditingController>
      notesControllers = {};

  @override
  void initState() {

    super.initState();

    charger();
  }

  Future<void> charger() async {

    final data =
        await controller.chargerTP(
      widget.idUe,
    );

    for (final e in data) {

      notesControllers[
          e['id_etudiant']] =

          TextEditingController(

        text:
            e['note_tp']
                ?.toString() ??
            "",
      );
    }

    setState(() {

      etudiants = data;

      etudiantsFiltres = data;

      loading = false;
    });
  }

  void rechercher(
    String valeur,
  ) {

    setState(() {

      etudiantsFiltres =
          etudiants.where((e) {

        final texte =

            "${e['matricule']} "

            "${e['nom']} "

            "${e['prenom']}"
                .toLowerCase();

        return texte.contains(
          valeur.toLowerCase(),
        );

      }).toList();
    });
  }

  Future<void> enregistrer() async {

    final List<Map<String, dynamic>>
        notes = [];

    for (final e in etudiants) {





final texte =
    notesControllers[
            e['id_etudiant']]
        ?.text
        .trim() ??
    "";

if (texte.isNotEmpty) {

  final note =
      double.parse(texte);

  if (note < 0 || note > 20) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Une note CC doit être comprise entre 0 et 30",
        ),
      ),
    );

    return;
  }
}




      notes.add({

        "id_etudiant":
            e['id_etudiant'],

        "id_ue":
            widget.idUe,

       "note_tp":
    notesControllers[
            e['id_etudiant']]
        ?.text
        .trim()
        .isEmpty ?? true

        ? null

        : double.parse(
            notesControllers[
                    e['id_etudiant']]
                !.text,
          ),
      });
    }

    final ok =
        await controller.enregistrerTP(
      notes,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(

          ok
              ? "Notes TP enregistrées"
              : "Erreur",
        ),
      ),
    );
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

        TextField(

          controller:
              rechercheController,

          onChanged: rechercher,

          decoration:
              const InputDecoration(

            prefixIcon:
                Icon(Icons.search),

            hintText:
                "Rechercher un étudiant...",
          ),
        ),

        const SizedBox(
          height: 15,
        ),

        Row(

          children: [

            ElevatedButton.icon(

              onPressed:
                  enregistrer,

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

              onPressed:
                  publier,

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
          height: 15,
        ),

        Container(

          padding:
              const EdgeInsets.symmetric(

            vertical: 12,

            horizontal: 10,
          ),

          color:
              Colors.orange.shade100,

          child: const Row(

            children: [

              Expanded(
                flex: 2,
                child: Text(
                  "Matricule",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Text(
                  "Nom",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: Text(
                  "Prénom",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  "TP",
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

    columnSpacing: 12,

    horizontalMargin: 12,

    source: TableauTPSource(

      etudiants: etudiantsFiltres,

      notesControllers: notesControllers,

      recherche: rechercheController.text,
    ),

    columns: const [

      DataColumn(
        label: Text("Matricule"),
      ),

      DataColumn(
        label: Text("Nom"),
      ),

      DataColumn(
        label: Text("Prénom"),
      ),

      DataColumn(
        label: Text("TP"),
      ),
    ],
  ),
),
      ],
    );
  }
}