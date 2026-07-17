import 'package:flutter/material.dart';

import '../../../inscription/config_globale/constant/api_constant.dart';
import '../models/requete_model.dart';
import 'requete_action_buttons.dart';
import '../controllers/requete_controller.dart';

class RequeteDetails extends StatelessWidget {
  final RequeteModel? requete;
  final controller = RequeteController();

   RequeteDetails({
    super.key,
    required this.requete,
  });

  @override
  Widget build(BuildContext context) {
    if (requete == null) {
      return const Center(
        child: Text(
          "Sélectionnez une requête",
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
          ),
        ],
      ),

      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Yaoundé, le ${requete!.date}",
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    requete!.etudiant,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    requete!.matricule,
                  ),

                  const SizedBox(height: 40),

                  Align(
                    alignment: Alignment.centerRight,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text("À"),

                        Text(
                          "${requete!.prenomEnseignant} ${requete!.nomEnseignant}",
                        ),

                        Text(
                          requete!.ue,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  Text(
                    "Objet : ${requete!.objet}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Monsieur,",
                  ),

                  const SizedBox(height: 20),

                  Text(
                    requete!.corps,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Dans l'attente d'une suite favorable, veuillez agréer Monsieur, l'expression de mon profond respect.",
                    style: TextStyle(
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 60),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      requete!.etudiant,
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Divider(),

                  const SizedBox(height: 20),

                  const Text(
                    "ANNEXES",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 15,
                    runSpacing: 15,

                    children:
                        requete!.piecesJointes.map(
                      (image) {

                        return ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),

                          child: Image.network(
                            "${ApiConstants.baseUrl}$image",
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ).toList(),
                  ),

                  if (requete!.reponse.isNotEmpty) ...[

                    const SizedBox(height: 40),

                    const Divider(),

                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      decoration: BoxDecoration(
                        color:
                            Colors.green.shade50,

                        borderRadius:
                            BorderRadius.circular(
                          15,
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          const Text(
                            "Décision de l'enseignant",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            requete!.reponse,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

         RequeteActionButtons(

  onValider: () async {

    final ok =
        await controller.repondreRequete(

      idRequete:
          requete!.idRequete,

      reponse:
          "Requête acceptée",

      statut:
          "RESOLUE",
    );

    if (context.mounted) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(

            ok
                ? "Requête validée"
                : "Erreur",
          ),
        ),
      );
    }
  },

  onRefuser: () async {

    final ok =
        await controller.repondreRequete(

      idRequete:
          requete!.idRequete,

      reponse:
          "Requête rejetée",

      statut:
          "REJETEE",
    );

    if (context.mounted) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(

            ok
                ? "Requête refusée"
                : "Erreur",
          ),
        ),
      );
    }
  },
),
        ],
      ),
    );
  }
}