class UeModel {

  final int? idUe;

  final String codeUe;

  final String nomUe;

  final int credit;

  final int idNiveau;

  final String nomSemestre;
  final bool hasTp;
  final int idFiliere;

final String nomFiliere;

  UeModel({

    this.idUe,

    required this.codeUe,

    required this.nomUe,

    required this.credit,

    required this.idNiveau,

    required this.nomSemestre,
    required this.hasTp,

    required this.idFiliere,
required this.nomFiliere,
  });

 factory UeModel.fromJson(
  Map<String, dynamic> json,
) {

  return UeModel(

    idUe:
        json['id_ue'],

    codeUe:
        json['code_ue'],

    nomUe:
        json['nom_ue'],

    credit:
        json['credit'],

    idNiveau:
        json['niveau'] != null
            ? json['niveau']['id_niveau']
            : 0,

    nomSemestre:
        json['semestre'],

    hasTp:
        json['has_tp'] ?? false,


        idFiliere:
    json['id_filiere'] ?? 0,

nomFiliere:
    json['nom_filiere'] ?? "",
  );
}

  Map<String, dynamic> toJson() {

    return {

      "code_ue":
          codeUe,

      "nom_ue":
          nomUe,

      "credit":
          credit,

      "id_niveau":
          idNiveau,

      "semestre":
          nomSemestre,


          "has_tp": hasTp,
    };
  }
}