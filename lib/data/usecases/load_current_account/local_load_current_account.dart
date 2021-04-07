import '../../cache/cache.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/models/models.dart';
import '../../../domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCurrentCacheStorage;

  LocalLoadCurrentAccount({@required this.fetchSecureCurrentCacheStorage});

  Future<Account> load() async {
    try{
      final token = await fetchSecureCurrentCacheStorage.fetchSecure('token');
      return Account(token);
    } catch (error){
      throw DomainError.unexpected;
    }
  }
}
