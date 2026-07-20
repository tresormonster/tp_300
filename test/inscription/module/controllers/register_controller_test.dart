import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/*import 'package:notes/inscription/module/controllers/register_controller.dart';
import 'package:notes/inscription/services/ia_api_service.dart';
import 'package:notes/inscription/models/etudiant.dart';

class MockApiService extends Mock implements IApiService {}

void main() {
  late MockApiService api;
  late RegisterController controller;

  setUp(() {
    api = MockApiService();
    controller = RegisterController(api);
  });

  final etudiant = Etudiant(
    matricule: "24S1234",
    nom: "Dupont",
    prenom: "Jean",
    email: "jean@test.com",
    motDePasse: "123456",
  );

  test("Inscription réussie", () async {
    when(() => api.register(any()))
        .thenAnswer((_) async => true);

    final result = await controller.register(etudiant);

    expect(result, true);

    verify(() => api.register(any())).called(1);
  });

  test("Inscription échouée", () async {
    when(() => api.register(any()))
        .thenAnswer((_) async => false);

    final result = await controller.register(etudiant);

    expect(result, false);

    verify(() => api.register(any())).called(1);
  });
}*/