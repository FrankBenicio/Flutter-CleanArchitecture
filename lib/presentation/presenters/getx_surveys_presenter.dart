import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/ui.dart';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class GetXSurveysPresenter implements SurveysPresenter{
  final LoadSurveys loadSurveys;

  final _isLoading = true.obs;
  final _surveys = Rx<List<SurveyViewModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;

  Stream<List<SurveyViewModel>> get loadSurveysStream => _surveys.stream;

  GetXSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async {
    try {
      _isLoading.value = true;

      final surveys = await loadSurveys.load();

      _surveys.value = surveys
          .map((survey) => SurveyViewModel(
          id: survey.id,
          question: survey.question,
          date: DateFormat('dd MMM yyyy').format(survey.dateTime),
          didAnswer: survey.didAnswer))
          .toList();
    } on DomainError {
      _surveys.subject.addError(UIError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }
}