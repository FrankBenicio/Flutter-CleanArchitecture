import '../factories.dart';

import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

LoadSurveys makeRemoteLoadSurveys() {
  return
      RemoteLoadSurveys(httpClient: makeHttpAdapter(), url: makeApiUrl('surveys'));
}
