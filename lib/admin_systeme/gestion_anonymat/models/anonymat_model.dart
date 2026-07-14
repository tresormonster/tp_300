class AnonymatModel {

  final int? idAnonymat;

  final String codeAnonymat;

  final bool isRattrapage;

  final String matricule;

  final String nom;

  final String prenom;

  AnonymatModel({

    this.idAnonymat,

    required this.codeAnonymat,

    required this.isRattrapage,

    required this.matricule,

    required this.nom,

    required this.prenom,
  });

  factory AnonymatModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return AnonymatModel(

      idAnonymat:
          json['id_anonymat'],

      codeAnonymat:
          json['code_anonymat'],

      isRattrapage:
          json['is_rattrapage'],

      matricule:
          json['matricule'],

      nom:
          json['nom'],

      prenom:
          json['prenom'],
    );
  }
}