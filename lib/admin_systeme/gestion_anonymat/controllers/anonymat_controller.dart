import '../models/anonymat_model.dart';

import '../services/anonymat_service.dart';

class AnonymatController {

  final service =

      AnonymatService();

  Future<List<AnonymatModel>>
      chargerAnonymats(

    int idUe,

    bool rattrapage,
  ) {

    return service.getAnonymats(

      idUe,

      rattrapage,
    );
  }

  Future<bool> genererAnonymats(

    int idUe,

    bool rattrapage,
  ) {

    return service.generer(

      idUe,

      rattrapage,
    );
  }


  Future<bool> supprimerAnonymats(

  int idUe,

  bool rattrapage,

) {

  return service.supprimer(

    idUe,

    rattrapage,
  );
}
}