import 'dart:convert';

import '../../data/http/http.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class HttpAdapter implements HttpClient<Map> {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request(
      {@required Uri url, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    try {
      if (method == 'post')
        response = await client.post(url, headers: headers, body: jsonBody);
      if (method == 'get')
        response = await client.get(url, headers: headers);
    } catch (error) {
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    if (response.statusCode == 200)
      return response.body.isEmpty ? null : jsonDecode(response.body);
    else if (response.statusCode == 204)
      return null;
    else if (response.statusCode == 400)
      throw HttpError.badRequest;
    else if (response.statusCode == 401)
      throw HttpError.unauthorized;
    else if (response.statusCode == 403)
      throw HttpError.forbidden;
    else if (response.statusCode == 404)
      throw HttpError.notFound;
    else
      throw HttpError.serverError;
  }
}
