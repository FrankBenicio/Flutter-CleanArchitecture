import 'package:meta/meta.dart';

import '../models/models.dart';

abstract class Authentication {
  Future<Account> auth({
    AuthenticationParams params
  });
}

class AuthenticationParams{
  final String email;
  final String secret;

  AuthenticationParams({@required this.email, @required this.secret});

  Map toJson() => {'email': this.email, 'password': this.secret};
}