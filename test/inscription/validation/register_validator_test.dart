import 'package:flutter_test/flutter_test.dart';
import 'package:notes/inscription/validation/register_validator.dart';

void main() {
  group('RegisterValidator - Matricule', () {
    test('matricule vide', () {
      expect(
        RegisterValidator.validateMatricule(''),
        'Le matricule est obligatoire',
      );
    });

    test('matricule trop court', () {
      expect(
        RegisterValidator.validateMatricule('123'),
        'Matricule trop court',
      );
    });

    test('matricule valide', () {
      expect(
        RegisterValidator.validateMatricule('24S1234'),
        null,
      );
    });
  });

  group('RegisterValidator - Nom', () {
    test('nom vide', () {
      expect(
        RegisterValidator.validateNom(''),
        'Le nom est obligatoire',
      );
    });

    test('nom valide', () {
      expect(
        RegisterValidator.validateNom('Dupont'),
        null,
      );
    });
  });

  group('RegisterValidator - Prenom', () {
    test('prenom vide', () {
      expect(
        RegisterValidator.validatePrenom(''),
        'Le prénom est obligatoire',
      );
    });

    test('prenom valide', () {
      expect(
        RegisterValidator.validatePrenom('Jean'),
        null,
      );
    });
  });

  group('RegisterValidator - Email', () {
    test('email vide', () {
      expect(
        RegisterValidator.validateEmail(''),
        "L'email est obligatoire",
      );
    });

    test('email invalide', () {
      expect(
        RegisterValidator.validateEmail('abc'),
        'Email invalide',
      );
    });

    test('email valide', () {
      expect(
        RegisterValidator.validateEmail('jean@test.com'),
        null,
      );
    });
  });

  group('RegisterValidator - Password', () {
    test('mot de passe vide', () {
      expect(
        RegisterValidator.validatePassword(''),
        'Mot de passe obligatoire',
      );
    });

    test('mot de passe trop court', () {
      expect(
        RegisterValidator.validatePassword('123'),
        'Minimum 6 caractères',
      );
    });

    test('mot de passe valide', () {
      expect(
        RegisterValidator.validatePassword('123456'),
        null,
      );
    });
  });
}