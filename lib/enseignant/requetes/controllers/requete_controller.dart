import '../models/requete_model.dart';
import '../state/requete_state.dart';

class RequeteController {

  RequeteState state =
      RequeteState(

    requetes: [

      RequeteModel(

        etudiant: "MON ETUDIANT",

        matricule: "21A345",

        type: "CC",

        corps:
            "Monsieur, ma note de CC semble incorrecte. Veuillez vérifier ma copie.",

        image:
            "https://via.placeholder.com/400",

        statut: "En attente",
      ),

      RequeteModel(

        etudiant: "JUNIOR TECH",

        matricule: "22B104",

        type: "TP",

        corps:
            "Je pense qu’il manque une note dans mon TP.",

        image:
            "https://via.placeholder.com/400",

        statut: "En attente",
      ),
    ],

    selectedRequete: null,
  );

  void selectRequete(
    RequeteModel requete,
  ) {

    state = RequeteState(

      requetes: state.requetes,

      selectedRequete: requete,
    );
  }
}