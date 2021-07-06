import '../../validation/protocols/protocols.dart';
import '../../validation/validators/validators.dart';

class ValidationBuilder {

  ValidationBuilder._();

  static ValidationBuilder _intance;

  String fieldName;

  List<FieldValidation> validations = [];

  static ValidationBuilder field(String fieldName) {
    _intance = ValidationBuilder._();

    _intance.fieldName = fieldName;

    return _intance;
  }

  ValidationBuilder required(){
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email(){
    validations.add(EmailValidation(fieldName));
    return this;
  }

  ValidationBuilder min(int size){
    validations.add(MingLengthValidation(field: fieldName, size: size));
    return this;
  }

  List<FieldValidation> build() => validations;
}
