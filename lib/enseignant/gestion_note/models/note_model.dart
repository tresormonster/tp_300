class NoteModel {

  final int? idEtudiant;

  final int? idUe;

  final String? matricule;

  final String? nom;

  final String? prenom;

  final String? codeAnonymat;

  double? noteCc;

  double? noteTp;

  double? noteSn;

  NoteModel({

    this.idEtudiant,

    this.idUe,

    this.matricule,

    this.nom,

    this.prenom,

    this.codeAnonymat,

    this.noteCc,

    this.noteTp,

    this.noteSn,
  });

  factory NoteModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return NoteModel(

      idEtudiant:
          json['id_etudiant'],

      idUe:
          json['id_ue'],

      matricule:
          json['matricule'],

      nom:
          json['nom'],

      prenom:
          json['prenom'],

      codeAnonymat:
          json['code_anonymat'],

      noteCc:
          json['note_cc']
              ?.toDouble(),

      noteTp:
          json['note_tp']
              ?.toDouble(),

      noteSn:
          json['note_sn']
              ?.toDouble(),
    );
  }
}