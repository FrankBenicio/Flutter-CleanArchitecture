import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(
      authentication: makeRemoteAuthentication(), validation: makeValidation());

}
