import 'package:flutter/material.dart';

import '../models/requete_model.dart';

class RequeteCard
    extends StatelessWidget {

  final RequeteModel requete;

  final VoidCallback onTap;

  const RequeteCard({

    super.key,

    required this.requete,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        margin:
            const EdgeInsets.only(
          bottom: 15,
        ),

        padding:
            const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),

          boxShadow: [

            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
        ),

        child: Row(

          children: [

            Container(

              padding:
                  const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color:
                    Colors.blue.shade50,

                borderRadius:
                    BorderRadius.circular(12),
              ),

            child: const Icon(
  Icons.description,
  color: Colors.blue,
),
            ),

            const SizedBox(width: 15),

     Expanded(
  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,

    children: [

      Text(
        requete.ue,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),

      const SizedBox(height: 5),

      Text(
        requete.etudiant,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 5),

      Text(
        requete.objet,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),

      const SizedBox(height: 5),

      Text(
        requete.date,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  ),
),

            Container(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              decoration: BoxDecoration(

                color:
                    Colors.orange.shade100,

                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: Text(

                requete.statut,

                style: TextStyle(

                  color:
                      Colors.orange.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}