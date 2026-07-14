// etudiant/controllers/note_etudiant_controller.dart

import '../services/note_etudiant_service.dart';


import 'dart:typed_data';

class NoteEtudiantController {

  final service =
      NoteEtudiantService();

  Future<List<dynamic>> chargerNotes(
    int idEtudiant,
  ) {

    return service.chargerNotes(
      idEtudiant,
    );
  }


  Future<Uint8List?> telechargerBulletin(
  int idEtudiant,
) {

  return service.telechargerBulletin(
    idEtudiant,
  );
}
}
