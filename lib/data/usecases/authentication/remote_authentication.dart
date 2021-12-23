import '../../../domain/usecases/usecases.dart';
import '../../models/models.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/models/models.dart';

import '../../http/http.dart';
import 'package:meta/meta.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final Uri url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  @override
  Future<Account> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();

    try {
      final httpResponse =
      await httpClient.request(url: url, method: 'post', body: body);

      return RemoteAccountModel.fromJson(httpResponse).toModel();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': this.email, 'password': this.password};
}
