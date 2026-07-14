import '../models/ue_model.dart';

import '../models/requete_model.dart';

import '../services/requete_service.dart';

class RequeteController {

  final RequeteService service =
      RequeteService();

  Future<List<UeModel>>
      chargerUes(
    int idNiveau,
  ) {

    return service
        .getUesByNiveau(
      idNiveau,
    );
  }

  Future<bool>
      soumettreRequete(
    RequeteModel requete,
  ) {

    return service
        .envoyerRequete(
      requete,
    );
  }
}