
import 'package:meta/meta.dart';

abstract class HttpClient {
  Future<dynamic> request({
    @required Uri url,
    @required String method,
    Map body,
  });
}
