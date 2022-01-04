import 'dart:async';

import 'package:ForDev/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class SurveysPresenterSpy extends Mock implements SurveysPresenter {}

void main() {
  SurveysPresenterSpy presenter;
  StreamController<List<SurveyViewModel>> loadSurveysController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SurveysPresenterSpy();

    loadSurveysController = StreamController<List<SurveyViewModel>>();
    when(presenter.loadSurveysStream)
        .thenAnswer((_) => loadSurveysController.stream);

    final surveysPage = GetMaterialApp(
      initialRoute: '/surveys',
      getPages: [GetPage(name: '/surveys', page: () => SurveysPage(presenter))],
    );

    await tester.pumpWidget(surveysPage);
  }

  List<SurveyViewModel> makeSurveys() => [
    SurveyViewModel(id: '1', question: 'question 1', date: 'date 1', didAnswer: true),
    SurveyViewModel(id: '2', question: 'question 2', date: 'date 2', didAnswer: false)

  ];


  tearDown(() {
    loadSurveysController.close();
  });

  testWidgets('Should call  LoadSurveys on page load',
      (WidgetTester tester) async {
    await loadPage(tester);
    verify(presenter.loadData()).called(1);
  });

 
  testWidgets('Should present error if loadSurveysStream fails', (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    loadSurveysController.addError(UIError.unexpected.description);
    await tester.pump();
    expect(find.text(R.strings.unexpected), findsOneWidget);
    expect(find.text(R.strings.recharge), findsOneWidget);
    expect(find.text('Question 1'), findsNothing);

    expect(find.byType(CircularProgressIndicator), findsNothing);


  });

  testWidgets('Should present list if loadSurveysStream succeeds', (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    loadSurveysController.add(makeSurveys());
    await tester.pump();
    expect(find.text(R.strings.unexpected), findsNothing);
    expect(find.text(R.strings.recharge), findsNothing);
    expect(find.text('question 1'), findsWidgets);
    expect(find.text('question 2'), findsWidgets);
    expect(find.text('date 1'), findsWidgets);
    expect(find.text('date 2'), findsWidgets);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call  LoadSurveys on reload button click',
          (WidgetTester tester) async {
        await loadPage(tester);

        loadSurveysController.addError(UIError.unexpected.description);
        await tester.pump();

        await tester.tap(find.text(R.strings.recharge));

        verify(presenter.loadData()).called(2);
      });
}
