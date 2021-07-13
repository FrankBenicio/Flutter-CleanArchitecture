import 'package:meta/meta.dart';

class Survey {
  final String id;
  final String question;
  final DateTime dataTime;
  final bool didAnswer;

  Survey(
      {@required this.id,
      @required this.question,
      @required this.dataTime,
      @required this.didAnswer});
}
