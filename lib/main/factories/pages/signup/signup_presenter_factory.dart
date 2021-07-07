import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

SignUpPresenter makeGetxSignUpPresenter() {
  return GetXSignUpPresenter(
      addAccount: makeRemoteAddAccount(), validation: makeSignUpValidation(), saveCurrentAccount: makeLocalSaveCurrentAccount());

}
