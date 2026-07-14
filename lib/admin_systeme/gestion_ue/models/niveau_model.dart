class NiveauModel {

  final int idNiveau;

  final String nomNiveau;

  NiveauModel({

    required this.idNiveau,

    required this.nomNiveau,
  });

  factory NiveauModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return NiveauModel(

      idNiveau:
          json['id_niveau'],

      nomNiveau:
          json['nom_niveau'],
    );
  }
}