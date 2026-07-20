import 'package:flutter/material.dart';

import '../controllers/note_controller.dart';

import 'package:data_table_2/data_table_2.dart';

import 'tableau_cc_source.dart';

class TableauCC extends StatefulWidget {
  final int idUe;

  const TableauCC({super.key, required this.idUe});

  @override
  State<TableauCC> createState() => _TableauCCState();
}

final PaginatorController
    paginatorController =
        PaginatorController();

class _TableauCCState extends State<TableauCC> {
  final controller = NoteController();

  final rechercheController = TextEditingController();

  List<dynamic> etudiants = [];

  List<dynamic> etudiantsFiltres = [];

  bool loading = true;

  Map<int, TextEditingController> notesControllers = {};

  @override
  void initState() {
    super.initState();

    charger();
  }

  @override
void didUpdateWidget(covariant TableauCC oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.idUe != widget.idUe) {

    notesControllers.clear();

    rechercheController.clear();

    etudiants.clear();

    etudiantsFiltres.clear();

    loading = true;

    charger();
  }
}

  Future<void> charger() async {
    final data = await controller.chargerCC(widget.idUe);

    for (final e in data) {
      notesControllers[e['id_etudiant']] = TextEditingController(
        text: e['note_cc']?.toString() ?? "",
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

  paginatorController.goToFirstPage();
}

  Future<void> enregistrer() async {
    final List<Map<String, dynamic>> notes = [];

    for (final e in etudiants) {
      final texte = notesControllers[e['id_etudiant']]?.text.trim() ?? "";

      if (texte.isNotEmpty) {
        final note = double.parse(texte);

        if (note < 0 || note > 30) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Une note CC doit être comprise entre 0 et 30"),
            ),
          );

          return;
        }
      }

      notes.add({
        "id_etudiant": e['id_etudiant'],

        "id_ue": widget.idUe,

        "note_cc":
            notesControllers[e['id_etudiant']]?.text.trim().isEmpty ?? true
                ? null
                : double.parse(notesControllers[e['id_etudiant']]!.text),
      });
    }

    final ok = await controller.enregistrerCC(notes);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? "Notes enregistrées" : "Erreur")),
    );
  }

  Future<void> publier() async {
    final ok = await controller.publierUe(widget.idUe);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? "Notes publiées" : "Erreur publication")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        TextField(
          controller: rechercheController,

          onChanged: (value) {

  rechercher(value);

  setState(() {});
},

          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),

            hintText: "Rechercher un étudiant...",
          ),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            ElevatedButton.icon(
              onPressed: enregistrer,

              icon: const Icon(Icons.save),

              label: const Text("Enregistrer"),
            ),

            const SizedBox(width: 10),

            ElevatedButton.icon(
              onPressed: publier,

              icon: const Icon(Icons.publish),

              label: const Text("Publier"),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),

          color: Colors.green.shade100,

          child: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Matricule",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                flex: 2,
                child: Text(
                  "Nom",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                flex: 3,
                child: Text(
                  "Prénom",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                child: Text(
                  "CC",
                  style: TextStyle(fontWeight: FontWeight.bold),
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

            source: TableauCCSource(

  etudiants:
      etudiantsFiltres,

  notesControllers:
      notesControllers,

  recherche:
      rechercheController.text,
),

            columns: const [
              DataColumn(label: Text("Matricule")),

              DataColumn(label: Text("Nom")),

              DataColumn(label: Text("Prénom")),

              DataColumn(label: Text("CC")),
            ],
          ),
        ),
      ],
    );
  }
}
