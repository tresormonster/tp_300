class Etudiant {
  final String matricule;

  final String email;

  final String motDePasse;

  Etudiant({
    required this.matricule,

    required this.email,

    required this.motDePasse,
  });

  Map<String, dynamic> toJson() => {
    "matricule": matricule,

    "email": email,

    "mot_de_passe": motDePasse,
  };
}
