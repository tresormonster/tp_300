class RequeteModel {

  final int idUe;

  final String typeProbleme;

  final String description;

  RequeteModel({

    required this.idUe,

    required this.typeProbleme,

    required this.description,
  });

  Map<String, dynamic> toJson() {

    return {

      "id_ue": idUe,

      "type_probleme":
          typeProbleme,

      "description":
          description,
    };
  }
}