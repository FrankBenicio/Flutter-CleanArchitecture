import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';

abstract class AddAccount {
  Future<Account> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String email;
  final String password;
  final String passwordConfirmation;
  final String name;

  @override
  List get props => [name, email, password, passwordConfirmation];

  AddAccountParams(
      {@required this.email,
      @required this.password,
      @required this.passwordConfirmation,
      @required this.name});
}
