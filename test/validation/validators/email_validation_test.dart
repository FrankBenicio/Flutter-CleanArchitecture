import 'package:ForDev/presentation/protocols/protocols.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    final error = sut.validate({'any_field': ''});

    expect(error, null);
  });

  test('Should return null if email is null', () {
    final error = sut.validate({'any_field': null});

    expect(error, null);
  });

  test('Should return null if email is valid', () {
    final emailValid = sut.validate({'any_field': 'frankbenicio.dev@gmail.com'});

    expect(emailValid, null);
  });

  test('Should return null if email is invalid', () {
    final emailInvalid = sut.validate({'any_field': 'frankbenicio.dev'});
    expect(emailInvalid, ValidationError.invalidField);
  });
}
