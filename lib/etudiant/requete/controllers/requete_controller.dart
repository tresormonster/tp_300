import 'package:file_picker/file_picker.dart';

import '../services/requete_service.dart';

class RequeteController {
  final service = RequeteService();

  Future<List<dynamic>> chargerRequetes(int idEtudiant) {
    return service.chargerRequetes(idEtudiant);
  }

  Future<bool> creerRequete({
    required int idEtudiant,

    required int idUe,

    required String objet,

    required String message,
    required List<PlatformFile> piecesJointes,
  }) {
    return service.creerRequete(
      idEtudiant: idEtudiant,

      idUe: idUe,

      objet: objet,

      message: message,

      piecesJointes: piecesJointes,
    );
  }

  Future<bool> modifierRequete({

  required int idRequete,

  required String objet,

  required String message,

  required List<String> piecesJointes,
}) {

  return service.modifierRequete(

    idRequete: idRequete,

    objet: objet,

    message: message,

    piecesJointes: piecesJointes,
  );
}

  Future<bool> supprimerRequete(int idRequete) {
    return service.supprimerRequete(idRequete);
  }

  Future<List<dynamic>> chargerUeContestables(int idEtudiant) {
    return service.chargerUeContestables(idEtudiant);
  }
}
