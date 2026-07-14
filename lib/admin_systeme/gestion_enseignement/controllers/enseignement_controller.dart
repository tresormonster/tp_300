import '../models/enseignement_model.dart';

import '../services/enseignement_service.dart';

class EnseignementController {

  final service =
      EnseignementService();

  Future<List<EnseignementModel>>
      chargerEnseignements() {

    return service.getAll();
  }

  Future<bool>
      ajouterEnseignement(
    EnseignementModel ens,
  ) {

    return service.create(
      ens,
    );
  }

  Future<bool>
      supprimerEnseignement(
    int id,
  ) {

    return service.delete(
      id,
    );
  }


  Future<bool>
    modifierEnseignement(

  int id,

  EnseignementModel ens,
) {

  return service.update(
    id,
    ens,
  );
}
}