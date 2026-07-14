import 'package:flutter/material.dart';

import '../../../admin_systeme/gestion_ue/controllers/ue_controller.dart';
import '../../../admin_systeme/gestion_ue/models/ue_model.dart';
import '../../../authentiification/services/token_service.dart';
class FiltreNotes
    extends StatefulWidget {

  final Function(
    UeModel,
    String,
  ) onCharger;

  const FiltreNotes({

  super.key,

  required this.onCharger,
});

  @override
  State<FiltreNotes> createState() =>
      _FiltreNotesState();
}

class _FiltreNotesState
    extends State<FiltreNotes> {

  final ueController =
      UeController();

  List<UeModel> ues = [];

  UeModel? ue;

  String? type;

  bool loading = true;
  String? filiereSelectionnee;

  final types = [

    "CC",

    "TP",

    "S1",

    "S1R",

    "S2",

    "S2R",
  ];

  @override
  void initState() {

    super.initState();

    chargerUes();
  }

  



Future<void> chargerUes() async {

  try {

    final idEnseignant =
        await TokenService.getId();

    print(
      "ID ENSEIGNANT = $idEnseignant",
    );

    final data =
        await ueController.chargerMesUes(
      idEnseignant!,
    );

    print(
      "NB UE = ${data.length}",
    );

    setState(() {

      ues = data;

      loading = false;
    });

  } catch (e) {

    print(
      "ERREUR UE : $e",
    );

    setState(() {

      loading = false;
    });
  }
}


List<String> filieresDisponibles() {

  return ues
      .map((e) => e.nomFiliere)
      .toSet()
      .toList();
}


List<UeModel> uesFiltrees() {

  if (filiereSelectionnee == null) {

    return [];
  }

  return ues.where(

    (e) =>

        e.nomFiliere ==
        filiereSelectionnee,

  ).toList();
}

 List<String> typesDisponibles() {

  if (ue == null) {

    return [];
  }

  List<String> liste = [

    "CC",
  ];

  if (ue!.hasTp) {

    liste.add("TP");
  }

  if (ue!.nomSemestre == "S1") {

    liste.add("S1");

    liste.add("S1R");
  }

  if (ue!.nomSemestre == "S2") {

    liste.add("S2");

    liste.add("S2R");
  }

  return liste;
}
 
 
  @override
  Widget build(
    BuildContext context,
  ) {

    if (loading) {

      return const Center(

        child:
            CircularProgressIndicator(),
      );
    }

    return Container(

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
        ),

        boxShadow: const [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 10,
          ),
        ],
      ),

      child: Row(

        children: [




Expanded(

  flex: 2,

  child:
      DropdownButtonFormField<String>(

    value: filiereSelectionnee,

    decoration:
        const InputDecoration(

      labelText: "Filière",
    ),

    items:
        filieresDisponibles()

            .map(

              (f) => DropdownMenuItem(

                value: f,

                child: Text(f),
              ),
            )

            .toList(),

    onChanged: (v) {

      setState(() {

        filiereSelectionnee = v;

        ue = null;

        type = null;
      });
    },
  ),
),







          Expanded(

            flex: 3,

            child:
                DropdownButtonFormField<UeModel>(

              value: ue,

              decoration:
                  const InputDecoration(

                labelText: "UE",
              ),

              items: uesFiltrees().map(

                (e) {

                  return DropdownMenuItem<UeModel>(

                    value: e,

                    child: Text(

                      "${e.codeUe} - ${e.nomUe}",
                    ),
                  );
                },
              ).toList(),

              onChanged: (v) {

                setState(() {

                ue = v;

type = null;
                });
              },
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          Expanded(

            flex: 2,

            child:
                DropdownButtonFormField<String>(

              value: type,

              decoration:
                  const InputDecoration(

                labelText:
                    "Type de note",
              ),

             items: typesDisponibles().map(

                (e) {

                  return DropdownMenuItem<String>(

                    value: e,

                    child: Text(e),
                  );
                },
              ).toList(),

              onChanged: (v) {

                setState(() {

                  type = v;
                });
              },
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          ElevatedButton.icon(

   onPressed: () {

  if (

      ue == null ||

      type == null) {

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(

      const SnackBar(

        content: Text(

          "Sélectionnez une UE et un type",
        ),
      ),
    );

    return;
  }

  widget.onCharger(

    ue!,

    type!,
  );
},
            icon: const Icon(
              Icons.search,
            ),

            label: const Text(
              "Charger",
            ),
          ),
        ],
      ),
    );
  }
}