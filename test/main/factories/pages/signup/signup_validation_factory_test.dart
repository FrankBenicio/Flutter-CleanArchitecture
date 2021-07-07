import 'package:ForDev/main/factories/factories.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignUpValidations();

    expect(validations, [
      RequiredFieldValidation('name'),
      MingLengthValidation(field: 'name', size: 3),
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MingLengthValidation(field: 'password', size: 3),
      RequiredFieldValidation('passwordConfirmation'),
      CompareFieldsValidation(field: 'passwordConfirmation', fieldToCompare: 'password'),
    ]);
  });
}
