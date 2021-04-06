import 'package:meta/meta.dart';
abstract class SaveSecureCacheStorage {
  Future saveSecure({@required String key, @required String value});
}