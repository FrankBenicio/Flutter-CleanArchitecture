import 'package:ForDev/presentation/protocols/validation.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';



void main() {
  CompareFieldsValidation sut;
  
  setUp((){
     sut = CompareFieldsValidation(field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should retorn error if values are not equal', () {

    final formData = {'any_field': 'any_value' ,'other_field': 'other_value'};

    final error = sut.validate(formData);

    expect(error, ValidationError.invalidField);
  });

  test('Should retorn null if values are equal', () {

    final formData = {'any_field': 'any_value' ,'other_field': 'any_value'};


    final error = sut.validate(formData);

    expect(error, null);
  });
}
