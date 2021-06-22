import 'package:ForDev/presentation/protocols/validation.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:test/test.dart';



void main() {
  CompareFieldsValidation sut;
  
  setUp((){
     sut = CompareFieldsValidation(field: 'any_field', valueToCompare: 'any_value');
  });
  test('Should retorn error if value is not equal', () {
    
    final error = sut.validate('wrong_value');

    expect(error, ValidationError.invalidField);
  });
}
