import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

SplashPresenter makeGetxSplashPresenter() {
  return GetXSplashPresenter(loadCurrentAccount: makeLocalLoadCurrentAccount());

}
