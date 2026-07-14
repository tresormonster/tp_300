
import 'package:notes/inscription/models/etudiant.dart';

import 'package:notes/inscription/services/api_service.dart';

class RegisterController {

  final ApiService api;

  RegisterController(this.api);

  Future<bool> register(
    Etudiant etudiant,
  ) {

    return api.register(
      etudiant,
    );
  }
}