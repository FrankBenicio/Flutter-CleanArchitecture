import '../models/models.dart';

abstract class LoadSurveys {
  Future<List<Survey>> load();
}
