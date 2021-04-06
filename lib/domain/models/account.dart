import 'package:equatable/equatable.dart';

class Account extends Equatable{
  final String token;

  Account(this.token);

  List get props => [token];

}