import '../models/requete_model.dart';

class RequeteState {

  final List<RequeteModel> requetes;

  final RequeteModel? selectedRequete;

  RequeteState({

    required this.requetes,

    required this.selectedRequete,
  });
}