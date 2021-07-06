import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';
import 'package:meta/meta.dart';

class MingLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;

  List get props => [field, size];

  MingLengthValidation({@required this.field, @required this.size});

  ValidationError validate(Map input) {
    return input[field] != null && input[field].length >= size
        ? null
        : ValidationError.invalidField;
  }
}
