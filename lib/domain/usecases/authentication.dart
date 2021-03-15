import 'package:meta/meta.dart';

import '../models/models.dart';

abstract class Authentication {
  Future<Account> auth({
    @required String email,
    @required String password
  });
}
