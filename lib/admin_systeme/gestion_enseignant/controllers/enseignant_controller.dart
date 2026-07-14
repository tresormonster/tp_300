import '../models/enseignant_model.dart';

import '../services/enseignant_service.dart';

class EnseignantController {

  final EnseignantService
      service =
          EnseignantService();

  Future<List<EnseignantModel>>
      chargerEnseignants() {

    return service.getAll();
  }

  Future<bool>
      ajouterEnseignant(
    EnseignantModel ens,
  ) {

    return service.create(
      ens,
    );
  }

  Future<bool>
      supprimerEnseignant(
    int id,
  ) {

    return service.delete(
      id,
    );
  }


  Future<bool>
    modifierEnseignant(

  int id,

  EnseignantModel ens,
) {

  return service.update(
    id,
    ens,
  );
}
}