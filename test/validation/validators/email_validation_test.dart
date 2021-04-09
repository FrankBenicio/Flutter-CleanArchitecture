import 'package:ForDev/presentation/protocols/protocols.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';



void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    final error = sut.validate('');

    expect(error, null);
  });

  test('Should return null if email is null', () {
    final error = sut.validate(null);

    expect(error, null);
  });

  test('Should return null if email is valid', () {
    final emailValid = sut.validate('frankbenicio.dev@gmail.com');

    expect(emailValid, null);
  });

  test('Should return null if email is invalid', () {
    final emailInvalid = sut.validate('frankbenicio.dev');

    expect(emailInvalid, ValidationError.invalidField);
  });
}
