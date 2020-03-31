// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_journal/screens/welcome_screen.dart';
import 'package:my_journal/widgets/rounded_button.dart';

void main() {
  testWidgets('WelcomeScreen is properly rendered',
      (WidgetTester tester) async {
    // Create WelcomeScreen
    Widget welcomeScreen = WelcomeScreen();

    // Build testable WelcomeScreen using WidgetTester
    await tester.pumpWidget(
      MaterialApp(
        home: welcomeScreen,
      ),
    );

    // Create Finders
    final widgetFinder = find.byWidget(welcomeScreen);
    final roundedButtonFinder = find.byType(RoundedButton(
      onPressed: () {},
    ).runtimeType);
    final faIconFinder = find.byIcon(FontAwesomeIcons.book);
    final titleFinder = find.text('myJournal');
    final registerFinder = find.text('Register');
    final loginFinder = find.text('Log In');

    // Verify that WelcomeScreen exists and is properly rendered
    expect(widgetFinder, findsOneWidget);
    expect(roundedButtonFinder, findsNWidgets(2));
    expect(faIconFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(registerFinder, findsOneWidget);
    expect(loginFinder, findsOneWidget);
  });
}
