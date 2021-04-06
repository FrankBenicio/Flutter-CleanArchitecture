import '../factories.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

SaveCurrentAccount makeLocalSaveCurrentAccount() {
  return
      LocalSaveCurrentAccount(saveSecureCacheStorage: makeLocalStorageAdapter());
}
