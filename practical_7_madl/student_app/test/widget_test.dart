import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:student_app/main.dart';

void main() {
  testWidgets('Task list and profile route display student information', (
    tester,
  ) async {
    await tester.pumpWidget(const StudentTaskApp());

    expect(find.text('Flutter Assignment'), findsOneWidget);
    expect(find.text('Hello, Aryan! 👋'), findsOneWidget);

    await tester.tap(find.byKey(const Key('profileButton')));
    await tester.pumpAndSettle();

    expect(find.text('Aryan Anande'), findsOneWidget);
    expect(find.text('Roll No. 5024105'), findsOneWidget);
  });

  testWidgets('Single tap opens task details', (tester) async {
    await tester.pumpWidget(const StudentTaskApp());
    await tester.tap(find.text('Flutter Assignment'));
    await tester.pumpAndSettle();

    expect(find.text('Task Details'), findsOneWidget);
    expect(find.text('Mobile Application Development'), findsOneWidget);
  });

  testWidgets('Double tap completes a task', (tester) async {
    await tester.pumpWidget(const StudentTaskApp());
    await tester.doubleTap(find.text('Flutter Assignment'));
    await tester.pump();

    expect(find.text('Task completed'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('Long press opens task actions and deletes task', (tester) async {
    await tester.pumpWidget(const StudentTaskApp());
    await tester.longPress(find.text('Database Project'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete task'));
    await tester.pumpAndSettle();

    expect(find.text('Database Project'), findsNothing);
  });
}
