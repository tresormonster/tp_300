class ImportHistorique {
  final int idImport;
  final String nomFichier;
  final String cycle;
  final String filiere;
  final String niveau;
  final int nombreEtudiants;
  final int importes;
  final int ignores;
  final DateTime dateImport;

  ImportHistorique({
    required this.idImport,
    required this.nomFichier,
    required this.cycle,
    required this.filiere,
    required this.niveau,
    required this.nombreEtudiants,
    required this.importes,
    required this.ignores,
    required this.dateImport,
  });

  factory ImportHistorique.fromJson(
      Map<String, dynamic> json) {
    return ImportHistorique(
      idImport: json["id_import"],
      nomFichier: json["nom_fichier"],
      cycle: json["cycle"],
      filiere: json["filiere"],
      niveau: json["niveau"],
      nombreEtudiants: json["nombre_etudiants"],
      importes: json["importes"],
      ignores: json["ignores"],
      dateImport: DateTime.parse(json["date_import"]),
    );
  }
}