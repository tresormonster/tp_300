import 'package:flutter/material.dart';

import '../importation/models/import_historique.dart';
import '../importation/services/historique_import_service.dart';

class HistoriqueImportsPage extends StatefulWidget {
  const HistoriqueImportsPage({super.key});

  @override
  State<HistoriqueImportsPage> createState() =>
      _HistoriqueImportsPageState();
}

class _HistoriqueImportsPageState
    extends State<HistoriqueImportsPage> {
  final HistoriqueImportService service =
      HistoriqueImportService();

  late Future<List<ImportHistorique>> historique;

  @override
  void initState() {
    super.initState();
    chargerHistorique();
  }

  void chargerHistorique() {
    historique = service.getHistorique();
  }

  Future<void> supprimer(int id) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmation"),
        content: const Text(
          "Supprimer cet import ?\n\nTous les étudiants associés seront également supprimés.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );

    if (confirmation != true) return;

    await service.supprimerImport(id);

    setState(() {
      chargerHistorique();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Historique des imports",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: FutureBuilder<List<ImportHistorique>>(
              future: historique,

              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                final imports = snapshot.data ?? [];

                if (imports.isEmpty) {
                  return const Center(
                    child: Text(
                      "Aucun historique d'import.",
                    ),
                  );
                }

                return LayoutBuilder(

                  builder: (context, constraints) {

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: ConstrainedBox(

                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),

                        child: DataTable(

                          columnSpacing: 35,
                          horizontalMargin: 18,

                          columns: const [

                            DataColumn(
                              label: Text(
                                "Fichier",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Cycle",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Filière",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Niveau",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Étudiants",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Action",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],

                          rows: imports.map((e) {

                            return DataRow(

                              cells: [

                                DataCell(

                                  SizedBox(
                                    width: 420,

                                    child: Text(
                                      e.nomFichier,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                DataCell(Text(e.cycle)),

                                DataCell(Text(e.filiere)),

                                DataCell(Text(e.niveau)),

                                DataCell(
                                  Text(
                                    e.importes.toString(),
                                  ),
                                ),

                                DataCell(
                                  Text(
                                    e.dateImport
                                        .toString()
                                        .substring(0, 10),
                                  ),
                                ),

                                DataCell(
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      supprimer(
                                        e.idImport,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );

                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}