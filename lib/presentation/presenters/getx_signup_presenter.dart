import '../../ui/ui.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../protocols/protocols.dart';

class GetXSignUpPresenter extends GetxController{
  final Validation validation;

  var _emailError = Rx<UIError>();
  var _nameError = Rx<UIError>();
  var _passwordError = Rx<UIError>();

  var _isFormValid = false.obs;

  Stream<UIError> get emailErrorStream => _emailError.stream;

  Stream<UIError> get nameErrorStream => _nameError.stream;

  Stream<UIError> get passwordErrorStream => _passwordError.stream;

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


  void validateName(String name) {
    _nameError.value = _validadeField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _passwordError.value = _validadeField(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = false;
  }

  void dispose() {}
}
