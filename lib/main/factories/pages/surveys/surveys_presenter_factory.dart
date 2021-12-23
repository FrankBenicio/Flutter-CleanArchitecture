import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

SurveysPresenter makeGetxSurveysPresenter() {
  return GetXSurveysPresenter(
    loadSurveys: makeRemoteLoadSurveys(),
  );
}
