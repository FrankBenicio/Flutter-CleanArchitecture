import 'package:ForDev/domain/models/models.dart';
import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future save(Account account) async {
    await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
  }
}

abstract class SaveSecureCacheStorage {
  Future saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  test('Should call CacheStorage with correct values', () async {
    final saveSecureCacheStorage = SaveSecureCacheStorageSpy();

    final sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);

    final account = Account(faker.guid.guid());

    await sut.save(account);

    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });
}
