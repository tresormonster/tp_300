class SemestreModel {

  final int idSemestre;

  final String nomSemestre;

  SemestreModel({

    required this.idSemestre,

    required this.nomSemestre,
  });

  factory SemestreModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return SemestreModel(

      idSemestre:
          json['id_semestre'],

      nomSemestre:
          json['nom_semestre'],
    );
  }
}