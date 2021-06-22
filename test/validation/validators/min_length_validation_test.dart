import 'package:ForDev/presentation/protocols/validation.dart';
import 'package:ForDev/validation/validators/validators.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';



void main() {
  MingLengthValidation sut;
  
  setUp((){
     sut = MingLengthValidation(field: 'any_field', size: 5);
  });
  test('Should retorn error if value is empty', () {
    
    final error = sut.validate('');

    expect(error, ValidationError.invalidField);
  });


  test('Should retorn error if value is null', () {

    final error = sut.validate(null);

    expect(error, ValidationError.invalidField);
  });

  test('Should retorn error if value is less than min size', () {

    final error = sut.validate(faker.randomGenerator.string(4, min: 1));

    expect(error, ValidationError.invalidField);
  });

  test('Should retorn null if value is equal than min size', () {

    final error = sut.validate(faker.randomGenerator.string(5, min: 5));

    expect(error, null);
  });

  test('Should retorn null if value is bigger than min size', () {

    final error = sut.validate(faker.randomGenerator.string(10, min: 6));

    expect(error, null);
  });
}
