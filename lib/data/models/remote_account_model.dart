import 'package:app/domain/models/account.dart';

class RemoteAccountModel{
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) => RemoteAccountModel(json['accessToken']);

  Account toModel() =>
      Account(this.accessToken);
}