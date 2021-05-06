import 'dart:async';

import 'package:ForDev/ui/pages/pages.dart';
import 'package:ForDev/ui/ui.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {

  SignUpPresenter presenter;
  StreamController<UIError> nameErrorController;
  StreamController<UIError> emailErrorController;
  StreamController<UIError> passwordErrorController;
  StreamController<UIError> passwordConfirmationErrorController;

  void initStreams() {
    emailErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    passwordConfirmationErrorController = StreamController<UIError>();
    nameErrorController = StreamController<UIError>();
  }

  void mockStreams() {
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);

    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);

    when(presenter.passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);

  }

  void closeStreams() {
    nameErrorController.close();

    emailErrorController.close();

    passwordErrorController.close();

    passwordConfirmationErrorController.close();

  }

  Future loadPage(WidgetTester tester) async {

    presenter = SignUpPresenterSpy();

    initStreams();

    mockStreams();

    final signupPage = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage(presenter)),
        GetPage(
            name: '/any_router',
            page: () => Scaffold(
                  body: Text('fake page'),
                ))
      ],
    );

    await tester.pumpWidget(signupPage);
  }


  tearDown((){
    closeStreams();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChield = find.descendant(
        of: find.bySemanticsLabel('Nome'), matching: find.byType(Text));

    expect(
      nameTextChield,
      findsOneWidget,
      reason:
      'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the hint text',
    );

    final emailTextChield = find.descendant(
        of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));

    expect(
      emailTextChield,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the hint text',
    );

    final passwordTextChield = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(
      passwordTextChield,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the hint text',
    );

    final passwordConfirmationTextChield = find.descendant(
        of: find.bySemanticsLabel('Confirmar senha'), matching: find.byType(Text));

    expect(
      passwordConfirmationTextChield,
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

        final name = faker.person.name();
        await tester.enterText(find.bySemanticsLabel('Nome'), name);
        verify(presenter.validateName(name));

        final email = faker.internet.email();
        await tester.enterText(find.bySemanticsLabel('E-mail'), email);
        verify(presenter.validateEmail(email));

        final password = faker.internet.password();
        await tester.enterText(find.bySemanticsLabel('Senha'), password);
        verify(presenter.validatePassword(password));

        final passwordConfirmation = password;
        await tester.enterText(find.bySemanticsLabel('Confirmar senha'), passwordConfirmation);
        verify(presenter.validatePasswordConfirmation(passwordConfirmation));
      });

  testWidgets('Should present email error',
          (WidgetTester tester) async {
        await loadPage(tester);

        emailErrorController.add(UIError.invalidField);
        await tester.pump();
        expect(find.text(UIError.invalidField.description), findsOneWidget);


        emailErrorController.add(UIError.requiredField);
        await tester.pump();
        expect(find.text(UIError.requiredField.description), findsOneWidget);

        emailErrorController.add(null);
        await tester.pump();
        final emailTextChield = find.descendant(
            of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
        expect(emailTextChield, findsOneWidget);
      });
}
