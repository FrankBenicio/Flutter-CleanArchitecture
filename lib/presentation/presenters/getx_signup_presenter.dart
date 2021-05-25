import '../../ui/ui.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../protocols/protocols.dart';

class GetXSignUpPresenter extends GetxController{
  final Validation validation;

  var _emailError = Rx<UIError>();
  var _isFormValid = false.obs;

  Stream<UIError> get emailErrorStream => _emailError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;


  GetXSignUpPresenter(
      {@required this.validation});

  UIError _validadeField({String field, String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void validateEmail(String email) {
    _emailError.value = _validadeField(field: 'email', value: email);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = false;
  }

  void dispose() {}
}
