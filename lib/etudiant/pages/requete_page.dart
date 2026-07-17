import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../inscription/config_globale/constant/api_constant.dart';
import '../../authentiification/services/token_service.dart';
import '../requete/controllers/requete_controller.dart';
import '../pages/nouvelle_requete_dialog.dart';

class RequetePage extends StatefulWidget {
  const RequetePage({super.key});

  @override
  State<RequetePage> createState() => _RequetePageState();
}

class _RequetePageState extends State<RequetePage> {
  final controller = RequeteController();

  String formaterDate(String date) {
    final d = DateTime.parse(date);

    return "${d.day}/${d.month}/${d.year} ${d.hour}:${d.minute}";
  }

  List<dynamic> requetes = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    charger();
  }

  Future<void> charger() async {
    final idEtudiant = await TokenService.getId();

    final data = await controller.chargerRequetes(idEtudiant!);

    setState(() {
      requetes = data;

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: const [
                  Text(
                    "Mes requêtes",

                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Historique de vos demandes",

                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E5B3A),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,

                    vertical: 18,
                  ),
                ),

                onPressed: () async {
                  final result = await showDialog(
                    context: context,

                    barrierDismissible: false,

                    builder: (_) {
                      return const NouvelleRequeteDialog();
                    },
                  );

                  if (result == true) {
                    charger();
                  }
                },

                icon: const Icon(Icons.add, color: Colors.white),

                label: const Text(
                  "Nouvelle requête",

                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          if (requetes.isEmpty)
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(30),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),
              ),

              child: const Center(
                child: Text(
                  "Aucune requête trouvée",

                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

          ...requetes.map((requete) => _buildCard(requete)),
        ],
      ),
    );
  }

  Widget _buildCard(dynamic requete) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (_) => Dialog(
                insetPadding: const EdgeInsets.all(30),
                child: SizedBox(width: 1000, child: _buildLettre(requete)),
              ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          children: [
            const Icon(Icons.description, size: 40, color: Color(0xFF1E5B3A)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requete["code_ue"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(requete["objet"]),
                  const SizedBox(height: 5),
                  Text(
                    "Enseignant : ${requete["prenom_enseignant"] ?? ""} ${requete["nom_enseignant"] ?? ""}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                _statusBadge(requete["statut"]),

                if (requete["statut"] == "EN_ATTENTE")
                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),

                        onPressed: () async {
                          final descriptionController = TextEditingController(
  text: requete["message"],
);

List<String> imagesExistantes =
    List<String>.from(
      requete["pieces_jointes"] ?? [],
    );

List<PlatformFile> nouvellesImages = [];

                          final result = await showDialog(
                            context: context,

                            builder: (_) {
                              return AlertDialog(
                                title: const Text("Modifier la requête"),

                              content: StatefulBuilder(
  builder: (context, setDialogState) {

    return SizedBox(
      width: 600,

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [

          TextField(
            controller: descriptionController,
            maxLines: 5,
          ),

          const SizedBox(height: 20),

         Wrap(
  spacing: 10,
  runSpacing: 10,

  children: [

    ...imagesExistantes.map(

      (image) => Stack(

        children: [

          Container(
            width: 100,
            height: 100,

            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: ClipRRect(

              borderRadius:
                  BorderRadius.circular(10),

              child: Image.network(

                "${ApiConstants.baseUrl}$image",

                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 0,
            right: 0,

            child: CircleAvatar(

              radius: 12,

              backgroundColor:
                  Colors.red,

              child: IconButton(

                padding: EdgeInsets.zero,

                icon: const Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.white,
                ),

                onPressed: () {

                  setDialogState(() {

                    imagesExistantes.remove(
                      image,
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    ).toList(),

    ElevatedButton.icon(

      icon: const Icon(Icons.add),

      label: const Text(
        "Ajouter",
      ),

      onPressed: () async {

        final result =
            await FilePicker.platform
                .pickFiles(

          allowMultiple: true,

          type: FileType.image,

          withData: true,
        );

        if (result != null) {

          setDialogState(() {

            nouvellesImages.addAll(
              result.files,
            );
          });
        }
      },
    ),
  ],
),
        ],
      ),
    );
  },
),

                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },

                                    child: const Text("Annuler"),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {
                    final nouvellesUrls =
    await controller.service
        .uploadPiecesJointes(
  nouvellesImages,
);

final toutesLesImages = [

  ...imagesExistantes,

  ...nouvellesUrls,
];

final ok =
    await controller
        .modifierRequete(

  idRequete:
      requete["id_requete"],

  objet:
      requete["objet"],

  message:
      descriptionController.text,

  piecesJointes:
      toutesLesImages,
);
                                      Navigator.pop(context, ok);
                                    },

                                    child: const Text("Enregistrer"),
                                  ),
                                ],
                              );
                            },
                          );

                          if (result == true) {
                            charger();
                          }
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),

                        onPressed: () async {
                          final confirmation = await showDialog<bool>(
                            context: context,

                            builder: (_) {
                              return AlertDialog(
                                title: const Text("Supprimer"),

                                content: const Text(
                                  "Voulez-vous vraiment supprimer cette requête ?",
                                ),

                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },

                                    child: const Text("Annuler"),
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },

                                    child: const Text("Supprimer"),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmation != true) {
                            return;
                          }

                          final ok = await controller.supprimerRequete(
                            requete["id_requete"],
                          );

                          if (ok) {
                            charger();
                          }
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLettre(dynamic requete) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Yaoundé, le ${formaterDate(requete["date_creation"])}",
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "${requete["prenom_etudiant"]} ${requete["nom_etudiant"]}",
            style: const TextStyle(fontSize: 20),
          ),
          Text(requete["matricule"]),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("À"),
                Text(
                  "${requete["prenom_enseignant"]} ${requete["nom_enseignant"]}",
                ),
                Text(requete["nom_ue"]),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Objet : ${requete["objet"]}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 30),
          Text(requete["message"]),
          const SizedBox(height: 30),
          if ((requete["pieces_jointes"] ?? []).isNotEmpty) ...[
            const Text(
              "Pièces jointes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children:
                  (requete["pieces_jointes"] as List).map<Widget>((piece) {
                    final imageUrl = "${ApiConstants.baseUrl}$piece";
                    print(imageUrl);

                    print("IMAGE URL AVANT NETWORK");

                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              child: InteractiveViewer(
                                minScale: 0.5,
                                maxScale: 5,

                                child: Image.network(
                                  imageUrl,
                                  errorBuilder: (context, error, stackTrace) {
                                    print("ERREUR IMAGE");
                                    print(error);

                                    return const Icon(Icons.error, size: 50);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),

                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return const Center(
                                child: Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
          const SizedBox(height: 40),
          if (requete["reponse"] != null)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Décision de l'enseignant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(requete["reponse"]),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _statusBadge(String statut) {
    Color color = Colors.blue;

    if (statut == "EN_ATTENTE" || statut == "Soumise") {
      color = Colors.blue;
    }

    if (statut == "TRAITEE" || statut == "En traitement") {
      color = Colors.orange;
    }

    if (statut == "RESOLUE" || statut == "Résolue") {
      color = Colors.green;
    }

    if (statut == "REJETEE" || statut == "Rejetée") {
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

      decoration: BoxDecoration(
        border: Border.all(color: color),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        statut,

        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _timeline(String statut) {
    return Row(
      children: [
        _step(true, "Soumise"),

        _line(),

        _step(statut != "EN_ATTENTE", "Traitement"),

        _line(),

        _step(statut == "RESOLUE", "Résolue"),
      ],
    );
  }

  Widget _line() {
    return Expanded(child: Container(height: 2, color: Colors.grey.shade300));
  }

  Widget _step(bool active, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,

          backgroundColor:
              active ? const Color(0xFF1E5B3A) : Colors.grey.shade300,

          child: Icon(Icons.check, color: active ? Colors.white : Colors.grey),
        ),

        const SizedBox(height: 8),

        Text(label),
      ],
    );
  }
}
