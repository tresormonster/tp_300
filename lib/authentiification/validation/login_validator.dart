class LoginValidator {

  // 🔥 EMAIL
  static String? validateEmail(
      String? value) {

    if (value == null ||
        value.trim().isEmpty) {

      return "Email obligatoire";
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