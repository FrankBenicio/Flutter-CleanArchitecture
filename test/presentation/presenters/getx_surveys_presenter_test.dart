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
  GetXSurveysPresenter sut;
  LoadSurveysSpy loadSurveys;

  setUp((){
    loadSurveys = LoadSurveysSpy();

    sut = GetXSurveysPresenter(loadSurveys: loadSurveys);
  });
  test('Should call LoadSurveys on loadData', () async{

    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });
}