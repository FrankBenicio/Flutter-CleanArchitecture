import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';


class GetXSurveysPresenter{
final LoadSurveys loadSurveys;

GetXSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async{
   await loadSurveys.load();
  }
}

class LoadSurveysSpy extends Mock implements LoadSurveys{}

void main(){
  test('Should call LoadSurveys on loadData', () async{

    final loadSurveys = LoadSurveysSpy();

    final sut = GetXSurveysPresenter(loadSurveys: loadSurveys);

    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });
}