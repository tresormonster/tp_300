import 'package:flutter/material.dart';

import '../../../authentiification/services/token_service.dart';

import '../controllers/requete_controller.dart';

import '../widgets/requete_filter_bar.dart';
import '../widgets/requete_list.dart';
import '../widgets/requete_details.dart';

class RequeteScreen extends StatefulWidget {
  const RequeteScreen({
    super.key,
  });

  @override
  State<RequeteScreen> createState() =>
      _RequeteScreenState();
}

class _RequeteScreenState
    extends State<RequeteScreen> {

  final controller =
      RequeteController();

  bool loading = true;
  String niveau = "Tous";
String filiere = "Toutes";
String ue = "Toutes";
String statut = "Toutes";

  @override
  void initState() {
    super.initState();

    charger();
  }


  List<String> get niveaux => [
      "Tous",
      ...controller.state.requetes
          .map((e) => e.niveau)
          .toSet(),
    ];

List<String> get filieres => [
      "Toutes",
      ...controller.state.requetes
          .map((e) => e.filiere)
          .toSet(),
    ];

List<String> get ues => [
      "Toutes",
      ...controller.state.requetes
          .map((e) => e.ue)
          .toSet(),
    ];

  Future<void> charger() async {

    final id =
        await TokenService.getId();

    if (id != null) {

      await controller
          .chargerRequetes(
        id,
      );
    }

    setState(() {

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }


    final requetesFiltrees = controller.state.requetes.where((r) {

  if (niveau != "Tous" && r.niveau != niveau) {
    return false;
  }

  if (filiere != "Toutes" && r.filiere != filiere) {
    return false;
  }

  if (ue != "Toutes" && r.ue != ue) {
    return false;
  }

  if (statut != "Toutes" && r.statut != statut) {
    return false;
  }

  return true;

}).toList();

    return Container(

      padding:
          const EdgeInsets.all(25),

      child: Column(

        children: [

          RequeteFilterBar(
  niveau: niveau,
  filiere: filiere,
  ue: ue,
  statut: statut,

  niveaux: niveaux,
  filieres: filieres,
  ues: ues,

  onNiveauChanged: (value) {
    setState(() {
      niveau = value!;
    });
  },

  onFiliereChanged: (value) {
    setState(() {
      filiere = value!;
    });
  },

  onUeChanged: (value) {
    setState(() {
      ue = value!;
    });
  },

  onStatutChanged: (value) {
    setState(() {
      statut = value!;
    });
  },
),

          Expanded(

            child: Row(

              children: [

                Expanded(

                  flex: 2,

                  child: RequeteList(

                    requetes: requetesFiltrees,

                    onSelect: (requete) {

                      setState(() {

                        controller
                            .selectRequete(
                          requete,
                        );
                      });
                    },
                  ),
                ),

                Expanded(

                  flex: 3,

                  child: RequeteDetails(

                    requete:
                        controller
                            .state
                            .selectedRequete,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}