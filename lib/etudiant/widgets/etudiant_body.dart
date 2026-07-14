import 'package:flutter/material.dart';

class EtudiantBody
    extends StatelessWidget {

  const EtudiantBody({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return const Center(

      child: Text(

        "Bienvenue dans votre espace étudiant",

        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }
}