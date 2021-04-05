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

  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;
  ValidationComposite sut;

  void mockValidation1(String error){
    when(validation1.field).thenReturn(error);
  }

  void mockValidation2(String error){
    when(validation2.field).thenReturn(error);
  }

  void mockValidation3(String error){
    when(validation3.field).thenReturn(error);
  }

  setUp((){
    validation1 = FieldValidationSpy();

    mockValidation1(null);

    when(validation1.validate(any)).thenReturn(null);

    validation2 = FieldValidationSpy();

    when(validation2.field).thenReturn('any_field');

    mockValidation2(null);

    validation3 = FieldValidationSpy();

    when(validation3.field).thenReturn('any_field');

    mockValidation3(null);



    sut = ValidationComposite([validation1, validation2]);
  });

  test('Should return null if all validations returns null or empty', () {

    mockValidation2('');
    var error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
