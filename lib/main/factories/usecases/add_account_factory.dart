import '../factories.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

AddAccount makeRemoteAddAccount() {
  return
      RemoteAddAccount(httpClient: makeHttpAdapter(), url: makeApiUrl('signup'));
}
