import '../http/http.dart';
import '../../domain/models/models.dart';
import 'package:meta/meta.dart';

class RemoteSurveyModel {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  RemoteSurveyModel(
      {@required this.id,
      @required this.question,
      @required this.date,
      @required this.didAnswer});

  factory RemoteSurveyModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'question', 'didAnswer', 'date']))
      throw HttpError.invalideData;

    return RemoteSurveyModel(
      id: json['id'],
      question: json['question'],
      didAnswer: json['didAnswer'],
      date: json['date'],
    );
  }

  Survey toModel() => Survey(
      id: id,
      didAnswer: didAnswer,
      question: question,
      dateTime: DateTime.parse(date));
}
