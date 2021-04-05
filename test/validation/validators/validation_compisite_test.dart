import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:ForDev/presentation/protocols/protocols.dart';
import 'package:ForDev/validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  String validate({@required String field, String value}) {
    return null;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  test('Should return null if all validations returns null or empty', () {
    final validation1 = FieldValidationSpy();

    when(validation1.field).thenReturn('any_field');

    when(validation1.validate(any)).thenReturn(null);

    final validation2 = FieldValidationSpy();

    when(validation1.field).thenReturn('any_field');

    when(validation1.validate(any)).thenReturn('');


    final sut = ValidationComposite([validation1, validation2]);

    var error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
