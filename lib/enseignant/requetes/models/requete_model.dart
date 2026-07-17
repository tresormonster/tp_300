class RequeteModel {

  final String etudiant;
  final String matricule;

  final String objet;
  final String ue;
  final String date;

  final String corps;

  final List<String> piecesJointes;

  final String statut;

  final String nomEnseignant;

  final String prenomEnseignant;

  final String reponse;
  final int idRequete;

  RequeteModel({
    required this.etudiant,
    required this.matricule,
    required this.objet,
    required this.ue,
    required this.date,
    required this.corps,
    required this.piecesJointes,
    required this.statut,
    required this.nomEnseignant,
    required this.prenomEnseignant,
    required this.reponse,
    required this.idRequete,
  });
}