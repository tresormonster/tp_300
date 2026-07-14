class FiliereModel {

  final int idFiliere;

  final String nomFiliere;

  FiliereModel({

    required this.idFiliere,

    required this.nomFiliere,
  });

  factory FiliereModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return FiliereModel(

      idFiliere:
          json['id_filiere'],

      nomFiliere:
          json['nom_filiere'],
    );
  }
}