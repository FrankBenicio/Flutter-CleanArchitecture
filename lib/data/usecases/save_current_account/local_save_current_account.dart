import '../../cache/cache.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/models/models.dart';
import '../../../domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});

  Future save(Account account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}