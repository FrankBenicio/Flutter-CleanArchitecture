import '../../../domain/usecases/usecases.dart';
import '../../models/models.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/models/models.dart';

import '../../http/http.dart';
import 'package:meta/meta.dart';

class RemoteAddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({@required this.httpClient, @required this.url});

  Future<Account> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();

    try {
    await httpClient.request(url: url, method: 'post', body: body);
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.passwordConfirmation});

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) =>
      RemoteAddAccountParams(
          name: params.name,
          email: params.email,
          password: params.password,
          passwordConfirmation: params.passwordConfirmation);

  Map toJson() => {
        'name': this.name,
        'email': this.email,
        'password': this.password,
        'passwordConfirmation': this.passwordConfirmation
      };
}