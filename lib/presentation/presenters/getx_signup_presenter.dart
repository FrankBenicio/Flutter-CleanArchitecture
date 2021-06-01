import 'package:ForDev/domain/usecases/add_account.dart';

import '../../ui/ui.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../protocols/protocols.dart';

class GetXSignUpPresenter extends GetxController {
  final Validation validation;
  final AddAccount addAccount;

  final _emailError = Rx<UIError>();
  final _nameError = Rx<UIError>();
  final _passwordError = Rx<UIError>();
  final _passwordConfirmationError = Rx<UIError>();
  final _mainError = Rx<UIError>();
  final _isFormValid = false.obs;
  final _isLoading = false.obs;

  String _name;
  String _email;
  String _password;
  String _passwordConfirmation;

  Stream<UIError> get emailErrorStream => _emailError.stream;

  Stream<UIError> get nameErrorStream => _nameError.stream;

  Stream<UIError> get passwordErrorStream => _passwordError.stream;

  Stream<UIError> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  Stream<UIError> get mainErrorStream => _mainError.stream;

  Stream<bool> get isFormValidStream => _isFormValid.stream;

  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetXSignUpPresenter({@required this.validation, @required this.addAccount});

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(
        field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  UIError _validateField({String field, String value}) {
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

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _nameError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  Future signUp() async {
    await addAccount
        .add(AddAccountParams(
        name: _name,
        email: _email,
        password: _password,
        passwordConfirmation: _passwordConfirmation
    ));
  }

  void dispose() {}
}
