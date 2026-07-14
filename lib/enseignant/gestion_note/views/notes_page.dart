import 'package:flutter/material.dart';

import '../widgets/filtre_notes.dart';
import '../widgets/tableau_cc.dart';
import '../widgets/tableau_tp.dart';
import '../widgets/tableau_sn.dart';
import '../widgets/tableau_rattrapage.dart';

class NotesPage extends StatefulWidget {

  const NotesPage({
    super.key,
  });

  @override
  State<NotesPage> createState() =>
      _NotesPageState();
}

class _NotesPageState
    extends State<NotesPage> {

  int? idUe;

  String? type;
  dynamic ueSelectionnee;

  @override
  Widget build(
    BuildContext context,
  ) {

    return Padding(

      padding:
          const EdgeInsets.all(25),

      child: Column(

        children: [

          FiltreNotes(

          onCharger: (

  selectedUe,

  selectedType,

) {

  setState(() {

    ueSelectionnee =
        selectedUe;

    idUe =
        selectedUe.idUe;

    type =
        selectedType;
  });
},
          ),

          const SizedBox(
            height: 20,
          ),

          Expanded(

            child:

                idUe == null ||

                        type == null

                    ? const Center(

                        child: Text(

                          "Sélectionnez une UE et un type de note",
                        ),
                      )

                   : type == "CC"

    ? TableauCC(
        idUe: idUe!,
      )

: type == "TP"

    ? TableauTP(
        idUe: idUe!,
      )

: type == "S1" ||
  type == "S2"

   ? TableauSN(
  idUe: idUe!,
  hasTp:
    ueSelectionnee!.hasTp,
)

: type == "S1R" ||
  type == "S2R"

    ?TableauRattrapage(
  idUe: idUe!,
  hasTp:
      ueSelectionnee!.hasTp,
)

    : const Center(
        child: Text(
          "Module en cours...",
        ),
      ),
          ),
        ],
      ),
    );
  }
}