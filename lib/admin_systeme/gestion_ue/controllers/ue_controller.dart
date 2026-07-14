import '../models/filiere_model.dart';
import '../models/niveau_model.dart';
import '../models/ue_model.dart';

import '../services/ue_service.dart';

class UeController {

  final UeService service =
      UeService();

  Future<List<FiliereModel>>
      chargerFilieres() {

    return service.getFilieres();
  }

  Future<List<NiveauModel>>
      chargerNiveaux(
    int idFiliere,
  ) {

    return service
        .getNiveauxByFiliere(
      idFiliere,
    );
  }

  Future<List<UeModel>>
      chargerUes() {

    return service.getAllUes();
  }

  Future<bool> ajouterUe(
    UeModel ue,
  ) {

    return service.createUe(
      ue,
    );
  }

  Future<bool> supprimerUe(
    int id,
  ) {

    return service.deleteUe(
      id,
    );
  }


  Future<List<UeModel>>
    chargerMesUes(
  int idEnseignant,
) {

  return service.getMesUes(
    idEnseignant,
  );
}
}