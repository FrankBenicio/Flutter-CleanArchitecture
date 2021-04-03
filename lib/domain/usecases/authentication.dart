import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';

abstract class Authentication {
  Future<Account> auth(
    AuthenticationParams params
  );
}

class AuthenticationParams extends Equatable{
  final String email;
  final String secret;


  @override
  List get props => [email, secret];

  AuthenticationParams({@required this.email, @required this.secret});

}