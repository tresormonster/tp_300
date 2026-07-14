import 'package:flutter/material.dart';

import '../../admin_systeme/gestion_enseignement/controllers/enseignement_controller.dart';
import '../../admin_systeme/gestion_enseignement/models/enseignement_model.dart';

import '../../admin_systeme/gestion_enseignant/controllers/enseignant_controller.dart';


import '../../admin_systeme/gestion_ue/controllers/ue_controller.dart';
import '../../admin_systeme/gestion_ue/models/ue_model.dart';
import '../../admin_systeme/gestion_enseignant/models/enseignant_model.dart';

class EnseignementsPage extends StatefulWidget {

  const EnseignementsPage({
    super.key,
  });

  @override
  State<EnseignementsPage>
      createState() =>
          _EnseignementsPageState();
}

class _EnseignementsPageState
    extends State<EnseignementsPage> {

  final controller =
      EnseignementController();

  final enseignantController =
      EnseignantController();

  final ueController =
      UeController();

  List<EnseignementModel>
      enseignements = [];

  List<EnseignantModel>
      enseignants = [];

  List<UeModel>
      ues = [];

  bool loading = true;

  @override
  void initState() {

    super.initState();

    charger();
  }

  Future<void> charger() async {

    final ens =
        await controller
            .chargerEnseignements();

    final profs =
        await enseignantController
            .chargerEnseignants();

    final listeUe =
        await ueController
            .chargerUes();

    setState(() {

      enseignements = ens;

      enseignants = profs;

      ues = listeUe;

      loading = false;
    });
  }

  Future<void> ajouter() async {

    EnseignantModel?
        enseignant;

    UeModel?
        ue;

    String? annee;
    final now =
    DateTime.now();

final anneeActuelle =
    "${now.year}-${now.year + 1}";

final anneePrecedente =
    "${now.year - 1}-${now.year}";

final anneeSuivante =
    "${now.year + 1}-${now.year + 2}";

    showDialog(

      context: context,

      builder: (_) {

        return StatefulBuilder(

          builder:
              (context, setDialogState) {

            return AlertDialog(

              title: const Text(
                "Nouvel Enseignement",
              ),

              content:
                  SingleChildScrollView(

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    DropdownButtonFormField<
                        EnseignantModel>(

                      value:
                          enseignant,

                      decoration:
                          const InputDecoration(

                        labelText:
                            "Enseignant",
                      ),

                      items:
                          enseignants.map(

                        (e) {

                          return DropdownMenuItem(

                            value: e,

                            child: Text(

                              "${e.nom} ${e.prenom}",
                            ),
                          );
                        },
                      ).toList(),

                      onChanged: (v) {

                        setDialogState(() {

                          enseignant = v;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    DropdownButtonFormField<
                        UeModel>(

                      value: ue,

                      decoration:
                          const InputDecoration(

                        labelText:
                            "UE",
                      ),

                      items: ues.map(

                        (e) {

                          return DropdownMenuItem(

                            value: e,

                            child: Text(
  e.codeUe,
),
                          );
                        },
                      ).toList(),

                      onChanged: (v) {

                        setDialogState(() {

                          ue = v;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                   DropdownButtonFormField<String>(

  value: annee,

  decoration:
      const InputDecoration(

    labelText:
        "Année académique",
  ),

  items: [

    anneePrecedente,

    anneeActuelle,

    anneeSuivante,

  ].map(

    (e) {

      return DropdownMenuItem(

        value: e,

        child: Text(e),
      );
    },
  ).toList(),

  onChanged: (v) {

    setDialogState(() {

      annee = v;
    });
  },
),
                  ],
                ),
              ),

              actions: [

                TextButton(

                  onPressed: () {

                    Navigator.pop(
                      context,
                    );
                  },

                  child:
                      const Text(
                    "Annuler",
                  ),
                ),

                ElevatedButton(

                  onPressed: () async {

                    if (

                    enseignant ==
                        null ||

                    ue ==
                        null ||

                    annee == null

                    ) {
                      return;
                    }

                    final enseignement =
                        EnseignementModel(

                      idEnseignant:
                          enseignant!
                              .idEnseignant!,

                      idUe:
                          ue!
                              .idUe!,

                      anneeAcademique:
    annee!,
                    );

                    final ok =
                        await controller
                            .ajouterEnseignement(
                      enseignement,
                    );

                    if (ok) {

                      if (mounted) {

                        Navigator.pop(
                          context,
                        );
                      }

                      charger();
                    }
                  },

                  child:
                      const Text(
                    "Ajouter",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
  Future<void> modifier(
  EnseignementModel ens,
) async {

  EnseignantModel? enseignant =
      enseignants.firstWhere(
    (e) =>
        e.idEnseignant ==
        ens.idEnseignant,
  );

  UeModel? ue =
      ues.firstWhere(
    (u) =>
        u.idUe ==
        ens.idUe,
  );

  String? annee =
      ens.anneeAcademique;

  final now =
      DateTime.now();

  final anneePrecedente =
      "${now.year - 1}-${now.year}";

  final anneeActuelle =
      "${now.year}-${now.year + 1}";

  final anneeSuivante =
      "${now.year + 1}-${now.year + 2}";

  showDialog(

    context: context,

    builder: (_) {

      return StatefulBuilder(

        builder:
            (context, setDialogState) {

          return AlertDialog(

            title: const Text(
              "Modifier Enseignement",
            ),

            content:
                SingleChildScrollView(

              child: Column(

                mainAxisSize:
                    MainAxisSize.min,

                children: [

                  DropdownButtonFormField<
                      EnseignantModel>(

                    value:
                        enseignant,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Enseignant",
                    ),

                    items:
                        enseignants.map(

                      (e) {

                        return DropdownMenuItem(

                          value: e,

                          child: Text(
                            "${e.nom} ${e.prenom}",
                          ),
                        );
                      },
                    ).toList(),

                    onChanged: (v) {

                      setDialogState(() {

                        enseignant = v;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  DropdownButtonFormField<
                      UeModel>(

                    value: ue,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "UE",
                    ),

                    items:
                        ues.map(

                      (e) {

                        return DropdownMenuItem(

                          value: e,

                          child: Text(
                            e.codeUe,
                          ),
                        );
                      },
                    ).toList(),

                    onChanged: (v) {

                      setDialogState(() {

                        ue = v;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  DropdownButtonFormField<
                      String>(

                    value: annee,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Année académique",
                    ),

                    items: [

                      anneePrecedente,
                      anneeActuelle,
                      anneeSuivante,

                    ].map((e) {

                      return DropdownMenuItem(

                        value: e,

                        child: Text(e),
                      );
                    }).toList(),

                    onChanged: (v) {

                      setDialogState(() {

                        annee = v;
                      });
                    },
                  ),
                ],
              ),
            ),

            actions: [

              TextButton(

                onPressed: () {

                  Navigator.pop(
                    context,
                  );
                },

                child:
                    const Text(
                  "Annuler",
                ),
              ),

              ElevatedButton(

                onPressed: () async {

                  final updated =
                      EnseignementModel(

                    idEnseignement:
                        ens.idEnseignement,

                    idEnseignant:
                        enseignant!
                            .idEnseignant!,

                    idUe:
                        ue!.idUe!,

                    anneeAcademique:
                        annee!,
                  );

                  final ok =
                      await controller
                          .modifierEnseignement(

                    ens.idEnseignement!,

                    updated,
                  );

                  if (ok) {

                    if (mounted) {

                      Navigator.pop(
                        context,
                      );
                    }

                    charger();
                  }
                },

                child:
                    const Text(
                  "Enregistrer",
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

  Future<void> supprimer(
    int id,
  ) async {

    await controller
        .supprimerEnseignement(
      id,
    );

    charger();
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

    return Padding(

      padding:
          const EdgeInsets.all(
        25,
      ),

      child: Column(

        children: [

          Row(

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              const Text(

                "Gestion Enseignements",

                style: TextStyle(

                  fontSize: 28,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              ElevatedButton.icon(

                onPressed:
                    ajouter,

                icon: const Icon(
                  Icons.add,
                ),

                label: const Text(
                  "Ajouter",
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          Expanded(

            child: ListView.builder(

              itemCount:
                  enseignements.length,

              itemBuilder:
                  (_, index) {

                final ens =
                    enseignements[index];

                return Card(

                  child: ListTile(

                    title: Text(

  ens.codeUe ?? '',
),

                    subtitle:
                        Text(

                      "${ens.nomEnseignant} - ${ens.anneeAcademique}",
                    ),

                   trailing: Row(

  mainAxisSize:
      MainAxisSize.min,

  children: [

    IconButton(

      icon: const Icon(
        Icons.edit,
        color: Colors.blue,
      ),

      onPressed: () {

        modifier(ens);
      },
    ),

    IconButton(

      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),

      onPressed: () {

        supprimer(
          ens.idEnseignement!,
        );
      },
    ),
  ],
),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}