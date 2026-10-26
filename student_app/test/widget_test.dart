
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:student_app/main.dart';

void main() {
  testWidgets('Student registration screen loads', (tester) async {
    await tester.pumpWidget(const StudentApp());

    expect(find.text('Student Registration'), findsOneWidget);
    expect(find.text('Register a Student'), findsOneWidget);
    expect(find.text('Registered Students (0)'), findsOneWidget);
  });

  testWidgets('Student can be added to the list', (tester) async {
    await tester.pumpWidget(const StudentApp());

    await tester.enterText(
      find.byKey(const Key('nameField')),
      'Aryan',
    );

    await tester.enterText(
      find.byKey(const Key('courseField')),
      'Flutter',
    );

    await tester.tap(find.byKey(const Key('addStudentButton')));
    await tester.pumpAndSettle();

    expect(find.text('Aryan'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Registered Students (1)'), findsOneWidget);
  });

  testWidgets('Empty form shows validation message', (tester) async {
    await tester.pumpWidget(const StudentApp());

    await tester.tap(find.byKey(const Key('addStudentButton')));
    await tester.pump();

    expect(find.text('Enter name and course'), findsOneWidget);
  });
}
