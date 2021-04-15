import 'dart:async';

import 'package:ForDev/ui/pages/pages.dart';
import 'package:ForDev/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {

  Future loadPage(WidgetTester tester) async {

    final signupPage = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(
            name: '/any_router',
            page: () => Scaffold(
                  body: Text('fake page'),
                ))
      ],
    );

    await tester.pumpWidget(signupPage);
  }


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
}
