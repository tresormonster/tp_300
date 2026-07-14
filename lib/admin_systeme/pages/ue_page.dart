import 'package:flutter/material.dart';

import '../../admin_systeme/gestion_ue/controllers/ue_controller.dart';

import '../../admin_systeme/gestion_ue/models/filiere_model.dart';
import '../../admin_systeme/gestion_ue/models/niveau_model.dart';
import '../../admin_systeme/gestion_ue/models/ue_model.dart';

class UesPage extends StatefulWidget {

  const UesPage({
    super.key,
  });

  @override
  State<UesPage> createState() =>
      _UesPageState();
}

class _UesPageState
    extends State<UesPage> {

  final controller =
      UeController();

  List<UeModel> ues = [];

  bool loading = true;

  @override
  void initState() {

    super.initState();

    charger();
  }

  Future<void> charger() async {

    final data =
        await controller.chargerUes();

    setState(() {

      ues = data;

      loading = false;
    });
  }

  Future<void> supprimer(
    int id,
  ) async {

    await controller.supprimerUe(
      id,
    );

    charger();
  }

  Future<void> ajouter() async {

    final nomController =
        TextEditingController();

    final creditController =
        TextEditingController();
        final codeController =
    TextEditingController();

    List<FiliereModel> filieres =
        await controller
            .chargerFilieres();

    List<NiveauModel> niveaux = [];

    FiliereModel? filiere;

    NiveauModel? niveau;

    String? semestre;
    bool hasTp = false;

    if (!mounted) return;

    showDialog(

      context: context,

      builder: (_) {

        return StatefulBuilder(

          builder:
              (context, setDialog) {

            return AlertDialog(

              title: const Text(
                "Nouvelle UE",
              ),

              content:
                  SingleChildScrollView(

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    DropdownButtonFormField<
                        FiliereModel>(

                      value: filiere,

                      decoration:
                          const InputDecoration(
                        labelText:
                            "Filière",
                      ),

                      items: filieres
                          .map(

                            (f) =>
                                DropdownMenuItem(

                              value: f,

                              child: Text(
                                f.nomFiliere,
                              ),
                            ),
                          )
                          .toList(),

                      onChanged: (v)
                          async {

                        filiere = v;

                        niveau = null;

                        niveaux =
                            await controller
                                .chargerNiveaux(
                          v!.idFiliere,
                        );

                        setDialog(() {});
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    DropdownButtonFormField<
                        NiveauModel>(

                      value: niveau,

                      decoration:
                          const InputDecoration(
                        labelText:
                            "Niveau",
                      ),

                      items: niveaux
                          .map(

                            (n) =>
                                DropdownMenuItem(

                              value: n,

                              child: Text(
                                n.nomNiveau,
                              ),
                            ),
                          )
                          .toList(),

                      onChanged: (v) {

                        niveau = v;

                        setDialog(() {});
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    DropdownButtonFormField<
                        String>(

                      value: semestre,

                      decoration:
                          const InputDecoration(
                        labelText:
                            "Semestre",
                      ),

                      items: const [

                        DropdownMenuItem(

                          value: "S1",

                          child: Text(
                            "Semestre 1",
                          ),
                        ),

                        DropdownMenuItem(

                          value: "S2",

                          child: Text(
                            "Semestre 2",
                          ),
                        ),
                      ],

                      onChanged: (v) {

                        semestre = v;

                        setDialog(() {});
                      },
                    ),





                    const SizedBox(
  height: 15,
),

CheckboxListTile(

  title: const Text(
    "Cette UE possède un TP",
  ),

  value: hasTp,

  controlAffinity:
      ListTileControlAffinity.leading,

  onChanged: (value) {

    setDialog(() {

      hasTp = value ?? false;
    });
  },
),

                    const SizedBox(
                      height: 15,
                    ),
                    

TextField(

  controller: codeController,

  decoration:
      const InputDecoration(

    labelText: "Code UE",
  ),
),

const SizedBox(
  height: 15,
),


                    TextField(

                      controller:
                          nomController,

                      decoration:
                          const InputDecoration(

                        labelText:
                            "Nom UE",
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    TextField(

                      controller:
                          creditController,

                      keyboardType:
                          TextInputType.number,

                      decoration:
                          const InputDecoration(

                        labelText:
                            "Crédit",
                      ),
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
    niveau == null ||
    semestre == null ||
    codeController.text.isEmpty ||
    nomController.text.isEmpty ||
    creditController.text.isEmpty
) {
  return;
}

                   final ue = UeModel(

  codeUe:
      codeController.text,

  nomUe:
      nomController.text,

  credit:
      int.parse(
    creditController.text,
  ),

  idNiveau:
      niveau!.idNiveau,

  nomSemestre:
      semestre!,


      hasTp: hasTp,


       idFiliere: 0,
  nomFiliere: "",
);

                    final ok =
                        await controller
                            .ajouterUe(
                      ue,
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
                MainAxisAlignment
                    .spaceBetween,

            children: [

              const Text(

                "Gestion UE",

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
                  ues.length,

              itemBuilder:
                  (_, index) {

                final ue =
                    ues[index];

                return Card(

                  child: ListTile(

                    leading:
                        const CircleAvatar(

                      child: Icon(
                        Icons.book,
                      ),
                    ),

                    title: Text(
                      ue.nomUe,
                    ),

                    subtitle: Text(
                      "${ue.nomSemestre} • Crédit : ${ue.credit}",
                    ),

                    trailing:
                        IconButton(

                      icon:
                          const Icon(
                        Icons.delete,
                        color:
                            Colors.red,
                      ),

                      onPressed:
                          () {

                        supprimer(
                          ue.idUe!,
                        );
                      },
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