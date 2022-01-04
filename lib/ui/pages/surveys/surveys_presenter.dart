import 'survey_viewmodel.dart';

abstract class SurveysPresenter {

  Stream<List<SurveyViewModel>> get loadSurveysStream;

  Future<void> loadData();

}
