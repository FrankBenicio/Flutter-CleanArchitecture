import 'package:ForDev/domain/models/models.dart';
import 'package:ForDev/domain/usecases/load_currrent_account.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCurrentCacheStorage fetchSecureCurrentCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCurrentCacheStorage});

  Future<Account> load() async {
    final token = await fetchSecureCurrentCacheStorage.fetchSecure('token');
    return Account(token);
  }
}

abstract class FetchSecureCurrentCacheStorage {
  Future<String> fetchSecure(String key);
}

class FetchSecureCurrentCacheStorageSpy extends Mock
    implements FetchSecureCurrentCacheStorage {}

void main() {
  FetchSecureCurrentCacheStorageSpy fetchSecureCurrentCacheStorage;

  LocalLoadCurrentAccount sut;

  String token;

  void mockFetchSecure(){
    when(fetchSecureCurrentCacheStorage.fetchSecure(any))
        .thenAnswer((_) async => token);
  }

  setUp(() {
    fetchSecureCurrentCacheStorage = FetchSecureCurrentCacheStorageSpy();

    sut = LocalLoadCurrentAccount(
        fetchSecureCurrentCacheStorage: fetchSecureCurrentCacheStorage);

    token = faker.guid.guid();

    mockFetchSecure();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCurrentCacheStorage.fetchSecure('token')).called(1);
  });

  test('Should return an Account', () async {

    final account = await sut.load();

    expect(account, Account(token));
  });
}
