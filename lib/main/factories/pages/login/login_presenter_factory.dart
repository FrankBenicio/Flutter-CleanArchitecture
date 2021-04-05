import '../../factories.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';

LoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(
      authentication: makeRemoteAuthentication(), validation: makeValidation());

}

LoginPresenter makeGetxLoginPresenter() {
  return GetXLoginPresenter(
      authentication: makeRemoteAuthentication(), validation: makeValidation());

}
