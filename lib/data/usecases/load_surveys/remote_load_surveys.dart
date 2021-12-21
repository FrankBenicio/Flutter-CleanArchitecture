import 'package:meta/meta.dart';
import '../../http/http.dart';
import '../../models/models.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/models/models.dart';
import '../../../domain/usecases/usecases.dart';

class RemoteLoadSurveys implements LoadSurveys {
  final Uri url;
  final HttpClient<List<Map>> httpClient;

  RemoteLoadSurveys({@required this.url, @required this.httpClient});

  Future<List<Survey>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');

      return httpResponse
          .map((json) => RemoteSurveyModel.fromJson(json).toModel())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
