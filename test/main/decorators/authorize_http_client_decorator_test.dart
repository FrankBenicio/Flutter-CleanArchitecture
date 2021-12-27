import 'package:ForDev/data/cache/cache.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AuthorizeHttpClientDecorator({@required this.fetchSecureCacheStorage});

  Future<void> request({
    @required Uri url,
    @required String method,
    Map body,
    Map headers,
  }) async {
    fetchSecureCacheStorage.fetchSecure('token');
  }
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  AuthorizeHttpClientDecorator sut;
  Uri url;
  String method;
  Map body;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();

    sut = AuthorizeHttpClientDecorator(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    
    url = Uri.parse(faker.internet.httpUrl());
    method = faker.randomGenerator.string(10);
    body = {'Any_key': 'Any_value'};
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {

    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
    
  });
}
