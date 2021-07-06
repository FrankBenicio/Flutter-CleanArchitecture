import 'package:ForDev/presentation/protocols/validation.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';



void main() {
  CompareFieldsValidation sut;
  
  setUp((){
     sut = CompareFieldsValidation(field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should return null on invalid cases', () {
    expect(sut.validate({'any_field': 'any_value'}), null);
    expect(sut.validate({'other_field': 'other_value'}), null);
    expect(sut.validate({}), null);

  });

  test('Should return null if values are equal', () {

    final formData = {'any_field': 'any_value' ,'other_field': 'any_value'};


    final error = sut.validate(formData);

    expect(error, null);
  });
}
