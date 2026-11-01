// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/main.dart';

void main() {
  testWidgets('Hello Flutter screen displays student details', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Hello Flutter 👋'), findsOneWidget);
    expect(find.text('Hello World!'), findsOneWidget);
    expect(find.text('Aryan Anande  |  Roll No. 5024105'), findsOneWidget);
    expect(find.byKey(const Key('getStartedButton')), findsOneWidget);
  });

  testWidgets('Get Started shows a welcome message', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const Key('getStartedButton')));
    await tester.pump();

    expect(find.text('Welcome to Flutter!'), findsOneWidget);
  });
}
