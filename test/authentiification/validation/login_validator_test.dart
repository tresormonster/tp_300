import 'package:flutter_test/flutter_test.dart';
import 'package:notes/authentiification/validation/login_validator.dart';

void main() {
  group('LoginValidator - Email', () {
    test('retourne une erreur si email vide', () {
      expect(
        LoginValidator.validateEmail(''),
        'Email obligatoire',
      );
    });

    test('retourne une erreur si email invalide', () {
      expect(
        LoginValidator.validateEmail('abc'),
        'Email invalide',
      );
    });

    test('retourne null si email valide', () {
      expect(
        LoginValidator.validateEmail('test@test.com'),
        null,
      );
    });
  });

  group('LoginValidator - Password', () {
    test('retourne une erreur si mot de passe vide', () {
      expect(
        LoginValidator.validatePassword(''),
        'Mot de passe obligatoire',
      );
    });

    test('retourne une erreur si mot de passe trop court', () {
      expect(
        LoginValidator.validatePassword('123'),
        'Minimum 6 caractères',
      );
    });

    test('retourne null si mot de passe valide', () {
      expect(
        LoginValidator.validatePassword('123456'),
        null,
      );
    });
  });
}