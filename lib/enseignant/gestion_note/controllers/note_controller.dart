import '../services/note_service.dart';

class NoteController {

  final service =
      NoteService();

  Future<List<dynamic>> chargerCC(
    int idUe,
  ) {

    return service.chargerCC(
      idUe,
    );
  }

  Future<List<dynamic>> chargerTP(
    int idUe,
  ) {

    return service.chargerTP(
      idUe,
    );
  }

  Future<bool> enregistrerCC(
    List<Map<String, dynamic>> notes,
  ) {

    return service.enregistrerCC(
      notes,
    );
  }

  Future<bool> enregistrerTP(
    List<Map<String, dynamic>> notes,
  ) {

    return service.enregistrerTP(
      notes,
    );
  }

  Future<bool> publierUe(
  int idUe,
) {

  return service.publierUe(
    idUe,
  );
}


Future<List<dynamic>> chargerSN(
  int idUe,
) {

  return service.chargerSN(
    idUe,
  );
}

Future<bool> enregistrerSN(
  List<Map<String, dynamic>> notes,
) {

  return service.enregistrerSN(
    notes,
  );
}



Future<List<dynamic>> chargerRattrapage(
  int idUe,
) {

  return service.chargerRattrapage(
    idUe,
  );
}

Future<bool> enregistrerRattrapage(
  List<Map<String, dynamic>> notes,
) {

  return service.enregistrerRattrapage(
    notes,
  );
}
}