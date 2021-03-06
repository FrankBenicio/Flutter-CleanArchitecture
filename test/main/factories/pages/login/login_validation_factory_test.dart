import 'package:ForDev/main/factories/factories.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MingLengthValidation(field: 'password', size: 3)
    ]);
  });
}
