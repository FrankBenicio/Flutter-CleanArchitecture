import '../../../data/http/http.dart';
import '../../decorators/decorators.dart';
import '../../factories/factories.dart';

HttpClient makeAuthorizeHttpClientDecoratorAdapter() =>
    AuthorizeHttpClientDecorator(decoratee: makeHttpAdapter(), fetchSecureCacheStorage: makeLocalStorageAdapter());
