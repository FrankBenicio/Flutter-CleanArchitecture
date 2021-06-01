import 'dart:async';

import 'package:ForDev/ui/pages/pages.dart';
import 'package:ForDev/ui/ui.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<UIError> emailErrorController;
  StreamController<UIError> passwordErrorController;
  StreamController<UIError> mainErrorController;
  StreamController<String> navigateToController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  void initStreams() {
    emailErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    mainErrorController = StreamController<UIError>();
    navigateToController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);

    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);

    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);

    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);

    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  }

  void closeStreams() {
    emailErrorController.close();

    passwordErrorController.close();

    mainErrorController.close();

    isFormValidController.close();

    isLoadingController.close();

    navigateToController.close();
  }

  Future loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();

    initStreams();

    mockStreams();

    final loginPage = GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage(presenter)),
        GetPage(
            name: '/any_router',
            page: () => Scaffold(
                  body: Text('fake page'),
                ))
      ],
    );

    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    closeStreams();
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

    emailErrorController.add(UIError.invalidField);

    await tester.pump();

    expect(find.text(UIError.invalidField.description), findsOneWidget);
  });

  testWidgets('Should present error if email is empty',
          (WidgetTester tester) async {
        await loadPage(tester);

        emailErrorController.add(UIError.requiredField);

        await tester.pump();

        expect(find.text(UIError.requiredField.description), findsOneWidget);
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

  testWidgets('Should present error if password is empty',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(UIError.requiredField);

    await tester.pump();

    expect(find.text(UIError.requiredField.description), findsOneWidget);
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

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid',
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

    final button = find.byType(RaisedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);

    await tester.pump();



    verify(presenter.auth()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if authentication fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.invalidCredentials);
    await tester.pump();

    expect(find.text(UIError.invalidCredentials.description), findsOneWidget);
  });

  testWidgets('Should present error message if authentication throws',
          (WidgetTester tester) async {
        await loadPage(tester);

        mainErrorController.add(UIError.unexpected);
        await tester.pump();

        expect(find.text(UIError.unexpected.description), findsOneWidget);
      });

  testWidgets('Should close streams on dispose', (WidgetTester tester) async {
    await loadPage(tester);

    addTearDown(() {
      verify(presenter.dispose()).called(1);
    });
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_router');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_router');

    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    //
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/login');


    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/login');
  });

  testWidgets('Should call go to SignUp on link click',
          (WidgetTester tester) async {
        await loadPage(tester);

        final button = find.text(R.strings.addAccount);
        await tester.ensureVisible(button);
        await tester.tap(button);

        await tester.pump();

        verify(presenter.goToSignUp()).called(1);
      });
}
