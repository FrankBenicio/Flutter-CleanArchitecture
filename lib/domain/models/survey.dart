import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Survey extends Equatable{
  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;

  List get props => ['id', 'question', 'dateTime', 'didAnswer'];

  Survey(
      {@required this.id,
      @required this.question,
      @required this.dateTime,
      @required this.didAnswer});
}
