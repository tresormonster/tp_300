import 'package:flutter/material.dart';

import '../models/requete_model.dart';

import 'requete_card.dart';

class RequeteList
    extends StatelessWidget {

  final List<RequeteModel> requetes;

  final Function(RequeteModel)
      onSelect;

  const RequeteList({

    super.key,

    required this.requetes,

    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(

      child: ListView.builder(

        itemCount: requetes.length,

        itemBuilder: (context, index) {

          final requete =
              requetes[index];

          return RequeteCard(

            requete: requete,

            onTap: () {

              onSelect(requete);
            },
          );
        },
      ),
    );
  }
}