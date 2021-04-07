import 'package:ForDev/data/cache/cache.dart';
import 'package:ForDev/data/usecases/usecases.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/domain/models/models.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class FetchSecureCurrentCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  FetchSecureCurrentCacheStorageSpy fetchSecureCurrentCacheStorage;

  LocalLoadCurrentAccount sut;

  String token;

  PostExpectation mockFetchSecureCall() =>
      when(fetchSecureCurrentCacheStorage.fetchSecure(any));

  void mockFetchSecure() {
    mockFetchSecureCall().thenAnswer((_) async => token);
  }

  void mockFetchSecureError() {
    when(fetchSecureCurrentCacheStorage.fetchSecure(any))
        .thenThrow(Exception());
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

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws',
      () async {
    final account = await sut.load();

    expect(account, Account(token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws',
      () async {
    mockFetchSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
