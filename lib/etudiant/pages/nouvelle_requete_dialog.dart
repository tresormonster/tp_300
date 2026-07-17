import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../authentiification/services/token_service.dart';
import '../requete/controllers/requete_controller.dart';

class NouvelleRequeteDialog extends StatefulWidget {
  const NouvelleRequeteDialog({super.key});

  @override
  State<NouvelleRequeteDialog> createState() => _NouvelleRequeteDialogState();
}

class _NouvelleRequeteDialogState extends State<NouvelleRequeteDialog> {
  final controller = RequeteController();

  final descriptionController = TextEditingController();

  List<dynamic> ues = [];

  bool loading = true;

  bool sending = false;

  dynamic ueSelectionnee;

  String? typeProbleme;
  List<PlatformFile> piecesJointes = [];

  @override
  void initState() {
    super.initState();

    chargerUes();
  }

  Future<void> choisirFichiers() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,

      withData: true,

      type: FileType.custom,

      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    print("RESULTAT PICKER");
    print(result);

    if (result != null) {
      print(result.files.length);

      setState(() {
        piecesJointes = [...piecesJointes, ...result.files];
      });

      print(piecesJointes.map((f) => f.name).toList());
    }
  }

  Future<void> chargerUes() async {
    final idEtudiant = await TokenService.getId();

    final data = await controller.chargerUeContestables(idEtudiant!);

    setState(() {
      ues = data;

      loading = false;
    });
  }

  Future<void> soumettre() async {
    if (ueSelectionnee == null) {
      return;
    }

    print("BOUTON SOUMETTRE");
    print("NB IMAGES = ${piecesJointes.length}");

    setState(() {
      sending = true;
    });

    final idEtudiant = await TokenService.getId();

    print("ID ETUDIANT = $idEtudiant");

    print("UE = $ueSelectionnee");
    print("ID UE = ${ueSelectionnee["id_ue"]}");
    print("TYPE = $typeProbleme");

    try {
      final ok = await controller.creerRequete(
        idEtudiant: idEtudiant!,

        idUe: ueSelectionnee["id_ue"],

        objet: typeProbleme!,

        message: descriptionController.text,

        piecesJointes: piecesJointes,
      );

      print("RESULTAT = $ok");

      setState(() {
        sending = false;
      });

      if (ok) {
        if (mounted) {
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      setState(() {
        sending = false;
      });

      print("ERREUR = $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Container(
        width: 700,

        constraints: const BoxConstraints(maxHeight: 750),

        padding: const EdgeInsets.all(30),

        child:
            loading
                ? const SizedBox(
                  height: 250,

                  child: Center(child: CircularProgressIndicator()),
                )
                : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            "Nouvelle requête",

                            style: TextStyle(
                              fontSize: 28,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "UE concernée",

                        style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<dynamic>(
                        value: ueSelectionnee,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),

                        items:
                            ues.map((ue) {
                              return DropdownMenuItem(
                                value: ue,

                                child: Text(
                                  "${ue["code_ue"]} - ${ue["nom_ue"]}",
                                ),
                              );
                            }).toList(),

                        onChanged: (value) {
                          setState(() {
                            ueSelectionnee = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Type de problème",

                        style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: typeProbleme,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),

                        items: const [
                          DropdownMenuItem(
                            value: "Erreur de calcul",

                            child: Text("Erreur de calcul"),
                          ),

                          DropdownMenuItem(
                            value: "Note manquante",

                            child: Text("Note manquante"),
                          ),

                          DropdownMenuItem(
                            value: "Erreur de saisie",

                            child: Text("Erreur de saisie"),
                          ),

                          DropdownMenuItem(
                            value: "Absence incorrecte",

                            child: Text("Absence incorrecte"),
                          ),

                          DropdownMenuItem(
                            value: "Autre",

                            child: Text("Autre"),
                          ),
                        ],

                        onChanged: (value) {
                          setState(() {
                            typeProbleme = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Description",

                        style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: descriptionController,

                        maxLines: 5,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          hintText: "Décrivez votre problème...",
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Pièces jointes",

                        style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      OutlinedButton.icon(
                        onPressed: choisirFichiers,

                        icon: const Icon(Icons.attach_file),

                        label: const Text("Ajouter des fichiers"),
                      ),

                      const SizedBox(height: 10),

                      if (piecesJointes.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,

                          physics: const NeverScrollableScrollPhysics(),

                          itemCount: piecesJointes.length,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,

                                crossAxisSpacing: 10,

                                mainAxisSpacing: 10,
                              ),

                          itemBuilder: (context, index) {
                            final fichier = piecesJointes[index];

                            final extension = fichier.extension?.toLowerCase();

                            final isImage =
                                extension == "png" ||
                                extension == "jpg" ||
                                extension == "jpeg";

                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isImage && fichier.bytes != null) {
                                      showDialog(
                                        context: context,

                                        builder: (_) {
                                          return Dialog(
                                            child: InteractiveViewer(
                                              child: Image.memory(
                                                fichier.bytes!,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },

                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),

                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),

                                    child:
                                        isImage
                                            ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),

                                              child: Image.memory(
                                                fichier.bytes!,

                                                fit: BoxFit.cover,
                                              ),
                                            )
                                            : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,

                                              children: [
                                                const Icon(
                                                  Icons.picture_as_pdf,

                                                  size: 50,

                                                  color: Colors.red,
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),

                                                  child: Text(
                                                    fichier.name,

                                                    textAlign: TextAlign.center,

                                                    maxLines: 2,

                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                  ),
                                ),

                                Positioned(
                                  right: 4,

                                  top: 4,

                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        piecesJointes.removeAt(index);
                                      });
                                    },

                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,

                                        shape: BoxShape.circle,
                                      ),

                                      child: const Padding(
                                        padding: EdgeInsets.all(3),

                                        child: Icon(
                                          Icons.close,

                                          color: Colors.white,

                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            child: const Text("Annuler"),
                          ),

                          const SizedBox(width: 15),

                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E5B3A),
                            ),

                            onPressed: sending ? null : soumettre,

                            icon:
                                sending
                                    ? const SizedBox(
                                      width: 16,

                                      height: 16,

                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),

                            label: const Text(
                              "Soumettre",

                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
