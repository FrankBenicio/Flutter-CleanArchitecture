import '../factories.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return
      LocalLoadCurrentAccount(fetchSecureCurrentCacheStorage: makeLocalStorageAdapter());
}
