import '../models/requete_model.dart';
import '../state/requete_state.dart';
import '../services/requete_service.dart';

class RequeteController {

  final service =
      RequeteService();

  RequeteState state =
      RequeteState(

    requetes: [],

    selectedRequete: null,
  );

  Future<void> chargerRequetes(
    int idEnseignant,
  ) async {

    final data =
        await service
            .chargerRequetes(
      idEnseignant,
    );

    state = RequeteState(

      requetes:

          data.map<RequeteModel>(
        (r) {

         return RequeteModel(
          idRequete:
    r["id_requete"],

  etudiant:
      "${r["prenom_etudiant"]} ${r["nom_etudiant"]}",

  matricule:
      r["matricule"],

  objet:
      r["objet"],

  ue:
      "${r["code_ue"]} - ${r["nom_ue"]}",

  date:
      r["date_creation"].toString(),

  corps:
      r["message"],

  piecesJointes:
      List<String>.from(
    r["pieces_jointes"] ?? [],
  ),

  statut:
      r["statut"],

  nomEnseignant:
      r["nom_enseignant"] ?? "",

  prenomEnseignant:
      r["prenom_enseignant"] ?? "",

  reponse:
      r["reponse"] ?? "",

      niveau: r["niveau"],

filiere: r["filiere"],
);
        },
      ).toList(),

      selectedRequete: null,
    );
  }

  void selectRequete(
    RequeteModel requete,
  ) {

    state = RequeteState(

      requetes:
          state.requetes,

      selectedRequete:
          requete,
    );
  }



  Future<bool> repondreRequete({
  required int idRequete,
  required String reponse,
  required String statut,
}) {

  return service.repondreRequete(

    idRequete: idRequete,

    reponse: reponse,

    statut: statut,
  );
}
}