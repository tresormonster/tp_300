import 'package:flutter/material.dart';

import '../models/requete_model.dart';

import 'requete_action_buttons.dart';

class RequeteDetails
    extends StatelessWidget {

  final RequeteModel? requete;

  const RequeteDetails({

    super.key,

    required this.requete,
  });

  @override
  Widget build(BuildContext context) {

    if (requete == null) {

      return const Expanded(

        child: Center(

          child: Text(
            "Sélectionnez une requête",
          ),
        ),
      );
    }

    return Expanded(

      child: Container(

        margin:
            const EdgeInsets.only(
          left: 20,
        ),

        padding:
            const EdgeInsets.all(25),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(22),

          boxShadow: [

            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
            ),
          ],
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              requete!.etudiant,

              style: const TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Matricule : ${requete!.matricule}",
            ),

            const SizedBox(height: 20),

            ClipRRect(

              borderRadius:
                  BorderRadius.circular(18),

              child: Image.network(

                requete!.image,

                height: 220,

                width: double.infinity,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            const Text(

              "Corps de la requête",

              style: TextStyle(

                fontWeight:
                    FontWeight.bold,

                fontSize: 18,
              ),
            ),

            const SizedBox(height: 12),

            Text(

              requete!.corps,

              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const Spacer(),

            const RequeteActionButtons(),
          ],
        ),
      ),
    );
  }
}