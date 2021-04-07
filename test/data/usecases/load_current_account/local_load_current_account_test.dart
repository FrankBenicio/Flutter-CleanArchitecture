import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalLoadCurrentAccount {
  final FetchSecureCurrentCacheStorage fetchSecureCurrentCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCurrentCacheStorage});

  Future load() async{
    fetchSecureCurrentCacheStorage.fetchSecure('token');
  }
}

abstract class FetchSecureCurrentCacheStorage{
  Future fetchSecure(String key);
}

 class FetchSecureCurrentCacheStorageSpy extends Mock implements FetchSecureCurrentCacheStorage{}

void main(){
  test('Should call FetchSecureCacheStorage with correct value', () async{
    final fetchSecureCurrentCacheStorage = FetchSecureCurrentCacheStorageSpy();
    final sut = LocalLoadCurrentAccount(fetchSecureCurrentCacheStorage: fetchSecureCurrentCacheStorage);

    await sut.load();

    verify(fetchSecureCurrentCacheStorage.fetchSecure('token')).called(1);

  });
}