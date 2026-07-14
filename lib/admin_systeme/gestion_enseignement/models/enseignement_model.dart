class EnseignementModel {

  final int? idEnseignement;

  final int idEnseignant;

  final int idUe;

  final String anneeAcademique;

  final String? nomEnseignant;

  final String? nomUe;

  final String? codeUe;

  EnseignementModel({

    this.idEnseignement,

    required this.idEnseignant,

    required this.idUe,

    required this.anneeAcademique,

    this.nomEnseignant,

    this.nomUe,

    this.codeUe,
  });

  factory EnseignementModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return EnseignementModel(

      idEnseignement:
          json['id_enseignement'],

      idEnseignant:
          json['enseignant']
              ['id_enseignant'],

      idUe:
          json['ue']
              ['id_ue'],

      anneeAcademique:
          json['annee_academique'],

      nomEnseignant:

          "${json['enseignant']['nom']} ${json['enseignant']['prenom']}",

      nomUe:
          json['ue']['nom_ue'],

      codeUe:
          json['ue']['code_ue'],
    );
  }

  Map<String, dynamic> toJson() {

    return {

      "id_enseignant":
          idEnseignant,

      "id_ue":
          idUe,

      "annee_academique":
          anneeAcademique,
    };
  }
}