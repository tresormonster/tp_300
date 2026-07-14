import '../models/etudiant.dart';
import '../services/ia_api_service.dart';

class RegisterRepository {

  final IApiService api;

  RegisterRepository(this.api);

  Future<List> getFilieres() => api.getFilieres();

  Future<List> getNiveaux() => api.getNiveaux();

  Future<bool> register(Etudiant e) => api.register(e);
}