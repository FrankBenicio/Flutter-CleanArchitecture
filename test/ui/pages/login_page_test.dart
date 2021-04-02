import 'dart:async';

import 'package:ForDev/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  Future loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();

    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);

    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);

    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);

    final loginPage = MaterialApp(
      home: LoginPage(presenter),
    );

    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();

    passwordErrorController.close();

    isFormValidController.close();

    isLoadingController.close();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChield = find.descendant(
        of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));

    expect(
      emailTextChield,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the hint text',
    );

    final senhaTextChield = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(
      senhaTextChield,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the hint text',
    );

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, null);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();

    await tester.enterText(find.bySemanticsLabel('E-mail'), email);

    verify(presenter.validateEmail(email));

    final password = faker.internet.password();

    await tester.enterText(find.bySemanticsLabel('Senha'), password);

    verify(presenter.validatePassword(password));
  });

  testWidgets('Should present error if email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');

    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present error if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(null);

    await tester.pump();

    final emailTextChield = find.descendant(
        of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));

    expect(emailTextChield, findsOneWidget);
  });

  testWidgets('Should present error if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('');

    await tester.pump();

    final emailTextChield = find.descendant(
        of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));

    expect(emailTextChield, findsOneWidget);
  });

  testWidgets('Should present error if password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error');

    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present error if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);

    await tester.pump();

    final passwordTextChield = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(passwordTextChield, findsOneWidget);
  });

  testWidgets('Should present error if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('');

    await tester.pump();

    final passwordTextChield = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(passwordTextChield, findsOneWidget);
  });

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should enable button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);

    await tester.pump();

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, isNull);
  });

  testWidgets('Should call authentication on form submit',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    verify(presenter.auth()).called(1);
  });

  testWidgets('Should present loading',
      (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });


  testWidgets('Should hide loading',
          (WidgetTester tester) async {
        await loadPage(tester);

        isLoadingController.add(true);
        await tester.pump();

        isLoadingController.add(false);
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
}
