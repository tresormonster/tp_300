import '../models/etudiant.dart';

abstract class IApiService {

  Future<List> getFilieres();

  Future<List> getNiveaux();

  Future<bool> register(Etudiant etudiant);
}