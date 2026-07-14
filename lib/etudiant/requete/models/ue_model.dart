class UeModel {

  final int idUe;

  final String nomUe;

  final int credit;

  UeModel({

    required this.idUe,

    required this.nomUe,

    required this.credit,
  });

  factory UeModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return UeModel(

      idUe: json['id_ue'],

      nomUe: json['nom_ue'],

      credit: json['credit'],
    );
  }
}