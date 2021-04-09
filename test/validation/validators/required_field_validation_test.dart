import 'package:ForDev/presentation/protocols/protocols.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  RequiredFieldValidation sut;
  setUp((){
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    final error = sut.validate('any_value');

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    final error = sut.validate('');

    expect(error, ValidationError.requiredField);
  });

  test('Should return error if value is null', () {
    final error = sut.validate(null);

    expect(error,  ValidationError.requiredField);
  });

}
