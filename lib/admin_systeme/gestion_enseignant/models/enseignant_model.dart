class EnseignantModel {

  final int? idEnseignant;

  final String nom;

  final String prenom;

  final String email;

  final String motDePasse;

  EnseignantModel({

    this.idEnseignant,

    required this.nom,

    required this.prenom,

    required this.email,

    required this.motDePasse,
  });

  factory EnseignantModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return EnseignantModel(

      idEnseignant:
          json['id_enseignant'],

      nom:
          json['nom'] ?? '',

      prenom:
          json['prenom'] ?? '',

      email:
          json['email'] ?? '',

      motDePasse: '',
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "nom": nom,

      "prenom": prenom,

      "email": email,

      "mot_de_passe":
          motDePasse,
    };
  }
}