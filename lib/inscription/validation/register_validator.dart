class RegisterValidator {

  // 🔥 MATRICULE
  static String? validateMatricule(
      String? value) {

    if (value == null ||
        value.trim().isEmpty) {

      return "Le matricule est obligatoire";
    }

    if (value.length < 4) {

      return "Matricule trop court";
    }

    return null;
  }

  // 🔥 NOM
  static String? validateNom(
      String? value) {

    if (value == null ||
        value.trim().isEmpty) {

      return "Le nom est obligatoire";
    }

    return null;
  }

  // 🔥 PRENOM
  static String? validatePrenom(
      String? value) {

    if (value == null ||
        value.trim().isEmpty) {

      return "Le prénom est obligatoire";
    }

    return null;
  }

  // 🔥 EMAIL
  static String? validateEmail(
      String? value) {

    if (value == null ||
        value.trim().isEmpty) {

      return "L'email est obligatoire";
    }

    final emailRegex = RegExp(
      r'^[^@]+@[^@]+\.[^@]+$',
    );

    if (!emailRegex.hasMatch(value)) {

      return "Email invalide";
    }

    return null;
  }

  // 🔥 PASSWORD
  static String? validatePassword(
      String? value) {

    if (value == null ||
        value.isEmpty) {

      return "Mot de passe obligatoire";
    }

    if (value.length < 6) {

      return "Minimum 6 caractères";
    }

    return null;
  }
}