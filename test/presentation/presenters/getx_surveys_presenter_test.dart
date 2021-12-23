import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/domain/models/models.dart';
import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:ForDev/presentation/presenters/presenters.dart';
import 'package:ForDev/ui/ui.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  GetXSurveysPresenter sut;
  LoadSurveysSpy loadSurveys;
  List<Survey> surveys;

  List<Survey> mockValidData() => [
        Survey(
            id: faker.guid.guid(),
            question: faker.lorem.sentence(),
            dateTime: DateTime(2021, 2, 20),
            didAnswer: true),
        Survey(
            id: faker.guid.guid(),
            question: faker.lorem.sentence(),
            dateTime: DateTime(2021, 2, 21),
            didAnswer: false),
      ];

  PostExpectation mockLoadSurveysCall() => when(loadSurveys.load());

  void mockLoadSurveys(List<Survey> data) {
    surveys = data;
    mockLoadSurveysCall().thenAnswer((_) async => data);
  }

  void mockLoadSurveysError() =>
      mockLoadSurveysCall().thenThrow(DomainError.unexpected);

  setUp(() {
    loadSurveys = LoadSurveysSpy();

    sut = GetXSurveysPresenter(loadSurveys: loadSurveys);

    mockLoadSurveys(mockValidData());
  });

  test('Should call LoadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });

  test('Should emit correct on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.loadSurveysStream.listen(expectAsync1((surveys) => expect(surveys, [
          SurveyViewModel(
              id: surveys[0].id,
              question: surveys[0].question,
              date: '20 Fev 2021',
              didAnswer: surveys[0].didAnswer),
          SurveyViewModel(
              id: surveys[1].id,
              question: surveys[1].question,
              date: '21 Fev 2021',
              didAnswer: surveys[1].didAnswer),
        ])));

    await sut.loadData();
  });

  test('Should emit correct on failure', () async {
    mockLoadSurveysError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.loadSurveysStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));

    await sut.loadData();
  });
}
