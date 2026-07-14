import 'package:flutter/material.dart';

import '../../authentiification/services/token_service.dart';
import '../controllers/note_etudiant_controller.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final controller = NoteEtudiantController();

  List<dynamic> notes = [];

  bool loading = true;

  List<dynamic> notesFiltrees = [];

  String recherche = "";
  String semestreSelectionne = "Tous";

  @override
  void initState() {
    super.initState();
    charger();
  }

  Future<void> charger() async {
    final idEtudiant = await TokenService.getId();

    final data = await controller.chargerNotes(idEtudiant!);

    setState(() {
      notes = data;

      notesFiltrees = data;

      loading = false;
    });
  }

  void filtrerNotes() {
    setState(() {
      notesFiltrees =
          notes.where((n) {
            final matchRecherche =
                n['code_ue'].toString().toLowerCase().contains(
                  recherche.toLowerCase(),
                ) ||
                n['nom_ue'].toString().toLowerCase().contains(
                  recherche.toLowerCase(),
                );

            final matchSemestre =
                semestreSelectionne == "Tous" ||
                n['semestre'] == semestreSelectionne;

            return matchRecherche && matchSemestre;
          }).toList();
    });


  }

  
    Future<void> telechargerBulletin() async {

  final idEtudiant =
      await TokenService.getId();

  final pdf =
      await controller.telechargerBulletin(
    idEtudiant!,
  );

  if (pdf == null) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Impossible de télécharger le bulletin",
        ),
      ),
    );

    return;
  }

  final blob =
      html.Blob([pdf]);

  final url =
      html.Url.createObjectUrlFromBlob(
    blob,
  );

  final anchor =
      html.AnchorElement(href: url)

        ..setAttribute(
          "download",
          "bulletin.pdf",
        )

        ..click();

  html.Url.revokeObjectUrl(url);
}

  Widget noteBox(dynamic note, String bareme) {
    if (note == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text("Non dispo", textAlign: TextAlign.center),
      );
    }

    return Text(
      "$note $bareme",
      style: const TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget statutBox(String decision) {
    Color color = Colors.grey;

    String texte = decision;

    switch (decision.toUpperCase()) {
      case "VALIDE":
        color = Colors.green;
        texte = "Validée";
        break;

      case "AJOURNE":
        color = Colors.red;
        texte = "Ajourné";
        break;

      case "RATTRAPAGE":
        color = Colors.orange;
        texte = "Autorisé au rattrapage";
        break;

      case "EN_ATTENTE":
        color = Colors.grey;
        texte = "Résultat non disponible";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texte,
        textAlign: TextAlign.center,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Mes notes",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            "Consultation détaillée de vos résultats",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),

          const SizedBox(height: 25),

          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.55,
                    child: TextField(
                      onChanged: (value) {
                        recherche = value;
                        filtrerNotes();
                      },
                      decoration: InputDecoration(
                        hintText: "Rechercher une UE...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: constraints.maxWidth * 0.18,
                    child: DropdownButtonFormField<String>(
                      value: semestreSelectionne,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Tous",
                          child: Text("Tous semestres"),
                        ),
                        DropdownMenuItem(
                          value: "S1",
                          child: Text("Semestre 1"),
                        ),
                        DropdownMenuItem(
                          value: "S2",
                          child: Text("Semestre 2"),
                        ),
                      ],
                      onChanged: (v) {
                        semestreSelectionne = v!;
                        filtrerNotes();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: telechargerBulletin,
                    icon: const Icon(Icons.download),
                    label: const Text("Télécharger bulletin"),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 25),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade300),
                ),
                columnSpacing: 35,
                dataRowMinHeight: 70,
                dataRowMaxHeight: 70,
                columns: const [
                  DataColumn(label: Text("UE")),
                  DataColumn(label: Text("Semestre")),
                  DataColumn(label: Text("CC")),
                  DataColumn(label: Text("TP")),
                  DataColumn(label: Text("SN")),
                  DataColumn(label: Text("Moyenne")),
                  DataColumn(label: Text("Statut")),
                ],
                rows:
                    notesFiltrees.map<DataRow>((n) {
                      Color couleurStatut = Colors.grey;
                      switch (n['couleur']) {
                        case 'green':
                          couleurStatut = Colors.green;
                          break;
                        case 'orange':
                          couleurStatut = Colors.orange;
                          break;
                        case 'red':
                          couleurStatut = Colors.red;
                          break;
                      }
                      return DataRow(
                        cells: [
                          DataCell(
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  n['code_ue'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(n['nom_ue']),
                              ],
                            ),
                          ),
                          DataCell(Text(n['semestre'] ?? "")),
                          DataCell(noteBox(n['note_cc'], "")),
                          DataCell(noteBox(n['note_tp'], "")),
                          DataCell(noteBox(n['note_sn'], "")),
                          DataCell(
                            Text(
                              n['note_finale']?.toString() ?? "-",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    n['couleur'] == 'green'
                                        ? Colors.green
                                        : n['couleur'] == 'orange'
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                          ),
                          DataCell(statutBox(n['statut'])),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
