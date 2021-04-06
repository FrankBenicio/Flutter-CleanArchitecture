import '../../../infra/cache/cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


LocalStorageAdapter makeLocalStorageAdapter() {
  final secureStorage = FlutterSecureStorage();

  return LocalStorageAdapter(secureStorage:secureStorage);
}
