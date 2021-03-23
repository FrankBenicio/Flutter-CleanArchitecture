import '../http/http.dart';
import '../../domain/models/models.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) {
    if(!json.containsKey('accessToken'))
      throw HttpError.invalideData;

    return RemoteAccountModel(json['accessToken']);
  }


  Account toModel() =>
      Account(this.accessToken);
}