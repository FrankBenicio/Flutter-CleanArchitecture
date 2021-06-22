import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';
import 'package:meta/meta.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String valueToCompare;

  CompareFieldsValidation(
      {@required this.field, @required this.valueToCompare});

  ValidationError validate(String value) {
    return ValidationError.invalidField;
  }
}
