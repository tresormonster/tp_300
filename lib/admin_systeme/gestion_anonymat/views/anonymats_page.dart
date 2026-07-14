import 'package:flutter/material.dart';

import '../../gestion_anonymat/controllers/anonymat_controller.dart';
import '../../gestion_anonymat/models/anonymat_model.dart';

import '../../gestion_ue/controllers/ue_controller.dart';
import '../../gestion_ue/models/ue_model.dart';
import '../pdf/anonymat_pdf.dart';

class AnonymatsPage extends StatefulWidget {

  const AnonymatsPage({super.key});

  @override
  State<AnonymatsPage> createState() =>
      _AnonymatsPageState();
}

class _AnonymatsPageState
    extends State<AnonymatsPage> {

  final controller =
      AnonymatController();

  final ueController =
      UeController();

  List<UeModel> ues = [];

  List<AnonymatModel> anonymats = [];

  UeModel? ue;

  String? session;

  bool loading = true;

  @override
  void initState() {

    super.initState();

    chargerUes();
  }

  Future<void> chargerUes() async {

    final data =
        await ueController.chargerUes();

    setState(() {

      ues = data;

      loading = false;
    });
  }

  Future<void> chargerAnonymats() async {

    if (ue == null || session == null) {
      return;
    }

    final data =
        await controller.chargerAnonymats(

      ue!.idUe!,

      session!.contains("R"),
    );

    setState(() {

      anonymats = data;
    });
  }

  Future<void> supprimer() async {

  if (

      ue == null ||

      session == null) {

    ScaffoldMessenger.of(context)

        .showSnackBar(

      const SnackBar(

        content: Text(

          "Sélectionnez une UE et une session",
        ),
      ),
    );

    return;
  }

  if (

      anonymats.isEmpty) {

    ScaffoldMessenger.of(context)

        .showSnackBar(

      const SnackBar(

        content: Text(

          "Aucun anonymat à supprimer",
        ),
      ),
    );

    return;
  }

  final confirmer =
      await showDialog<bool>(

    context: context,

    builder: (_) {

      return AlertDialog(

        title: const Text(

          "Confirmation",
        ),

        content: Text(

          "Supprimer tous les anonymats de ${ue!.codeUe} ($session) ?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                context,
                false,
              );
            },

            child:
                const Text("Annuler"),
          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(
                context,
                true,
              );
            },

            child:
                const Text("Supprimer"),
          ),
        ],
      );
    },
  );

  if (confirmer != true) {
    return;
  }

  final ok =
      await controller
          .supprimerAnonymats(

    ue!.idUe!,

    session!.contains("R"),
  );

  if (ok) {

    chargerAnonymats();

    if (mounted) {

      ScaffoldMessenger.of(context)

          .showSnackBar(

        const SnackBar(

          content: Text(

            "Anonymats supprimés",
          ),
        ),
      );
    }
  }
}

  Future<void> generer() async {

    if (ue == null || session == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Sélectionnez une UE et une session",
          ),
        ),
      );

      return;
    }


    

    final ok =
        await controller.genererAnonymats(

      ue!.idUe!,

      session!.contains("R"),
    );

    if (ok) {

      chargerAnonymats();

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(

            content: Text(
              "Anonymats générés",
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Center(

        child: CircularProgressIndicator(),
      );
    }

    return Padding(

      padding: const EdgeInsets.all(25),

      child: Column(

        children: [

          const Text(

            "Gestion des anonymats",

            style: TextStyle(

              fontSize: 28,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

    Row(

  crossAxisAlignment: CrossAxisAlignment.end,

  children: [

    SizedBox(

      width: 320,

      child: DropdownButtonFormField<UeModel>(

        value: ue,

        decoration: const InputDecoration(

          labelText: "UE",
        ),

        items: ues.map((e) {

          return DropdownMenuItem(

            value: e,

            child: Text(e.codeUe),
          );

        }).toList(),

        onChanged: (v) {

          setState(() {

            ue = v;

            session = null;

            anonymats.clear();
          });
        },
      ),
    ),

    const SizedBox(width: 20),

    SizedBox(

      width: 120,

      child: DropdownButtonFormField<String>(

        value: session,

        decoration: const InputDecoration(

          labelText: "Session",
        ),

        items: ue == null

            ? []

            : (

                ue!.nomSemestre == "S1"

                    ? [

                        const DropdownMenuItem(

                          value: "S1",

                          child: Text("S1"),
                        ),

                        const DropdownMenuItem(

                          value: "S1R",

                          child: Text("S1R"),
                        ),
                      ]

                    : [

                        const DropdownMenuItem(

                          value: "S2",

                          child: Text("S2"),
                        ),

                        const DropdownMenuItem(

                          value: "S2R",

                          child: Text("S2R"),
                        ),
                      ]
              ),

        onChanged: (v) async {

          setState(() {

            session = v;
          });

          chargerAnonymats();
        },
      ),
    ),

    const Spacer(),

    ElevatedButton.icon(

      onPressed: generer,

      icon: const Icon(Icons.badge),

      label: const Text("Générer"),
    ),

    const SizedBox(width: 10),

    ElevatedButton.icon(

      onPressed: () {

  if (

      ue == null ||

      session == null ||

      anonymats.isEmpty) {

    ScaffoldMessenger.of(context)

        .showSnackBar(

      const SnackBar(

        content: Text(

          "Aucun anonymat à imprimer",
        ),
      ),
    );

    return;
  }

  AnonymatPdf.imprimer(

    ue: ue!.codeUe,

    session: session!,

    anonymats: anonymats,
  );
},

      icon: const Icon(Icons.print),

      label: const Text("Imprimer"),
    ),

    const SizedBox(width: 10),

    ElevatedButton.icon(

      style: ElevatedButton.styleFrom(

        backgroundColor: Colors.red,
      ),

      onPressed: supprimer,

      icon: const Icon(Icons.delete),

      label: const Text("Supprimer"),
    ),
  ],
),

          const SizedBox(height: 10),
Expanded(

  child: Container(

    width: double.infinity,

    decoration: BoxDecoration(

      color: Colors.white,

      borderRadius: BorderRadius.circular(12),

      border: Border.all(
        color: Colors.grey.shade300,
      ),
    ),

    child: Column(

      children: [

        // ENTÊTE

        Container(

          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),

          decoration: BoxDecoration(

            color: Colors.green.shade100,

            borderRadius: const BorderRadius.only(

              topLeft: Radius.circular(12),

              topRight: Radius.circular(12),
            ),
          ),

          child: const Row(

            children: [

              Expanded(

                flex: 1,

                child: Center(

                  child: Text(

                    "Code",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Expanded(

                flex: 2,

                child: Center(

                  child: Text(

                    "Matricule",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Expanded(

                flex: 2,

                child: Center(

                  child: Text(

                    "Nom",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Expanded(

                flex: 3,

                child: Center(

                  child: Text(

                    "Prénom",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Expanded(

                flex: 1,

                child: Center(

                  child: Text(

                    "Session",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(

  child: anonymats.isEmpty

    ? Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(

              Icons.badge_outlined,

              size: 80,

              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 20),

            Text(

              ue == null

                  ? "Sélectionnez une UE."

                  : session == null

                      ? "Sélectionnez une session."

                      : "Aucun anonymat n'a été généré\npour cette UE.",

              textAlign: TextAlign.center,

              style: TextStyle(

                fontSize: 20,

                color: Colors.grey.shade600,

                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 15),

            if (ue != null && session != null)

              ElevatedButton.icon(

                onPressed: generer,

                icon: const Icon(Icons.badge),

                label: const Text("Générer les anonymats"),
              ),
          ],
        ),
      )

    : ListView.builder(

            itemCount: anonymats.length,

            itemBuilder: (_, index) {

              final a = anonymats[index];

              return Container(

                padding: const EdgeInsets.symmetric(

                  vertical: 14,
                ),

                decoration: BoxDecoration(

                  border: Border(

                    bottom: BorderSide(

                      color: Colors.grey.shade300,
                    ),
                  ),
                ),

                child: Row(

                  children: [

                    Expanded(

                      flex: 1,

                      child: Center(

                        child: Text(
                          a.codeAnonymat,
                        ),
                      ),
                    ),

                    Expanded(

                      flex: 2,

                      child: Center(

                        child: Text(
                          a.matricule,
                        ),
                      ),
                    ),

                    Expanded(

                      flex: 2,

                      child: Center(

                        child: Text(
                          a.nom,
                        ),
                      ),
                    ),

                    Expanded(

                      flex: 3,

                      child: Center(

                        child: Text(
                          a.prenom,
                        ),
                      ),
                    ),

                    Expanded(

                      flex: 1,

                      child: Center(

                        child: Text(
                          session!,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
),
        ],
      ),
    );
  }
}