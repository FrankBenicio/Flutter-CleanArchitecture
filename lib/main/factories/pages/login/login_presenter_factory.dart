import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

LoginPresenter makeGetxLoginPresenter() {
  return GetXLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
}
