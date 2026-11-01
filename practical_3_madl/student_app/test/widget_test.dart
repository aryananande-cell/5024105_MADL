import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:student_app/main.dart';

void main() {
  testWidgets('Student profile displays profile and academic details', (
    tester,
  ) async {
    await tester.pumpWidget(const StudentApp());

    expect(find.text('Aryan Anande'), findsOneWidget);
    expect(find.text('Roll No. 5024105'), findsOneWidget);
    expect(find.text('Semester'), findsOneWidget);
    expect(find.text('8.84'), findsOneWidget);
    expect(find.text('Today\'s Motivation'), findsOneWidget);
  });

  testWidgets('Saving a goal displays it on the profile', (tester) async {
    await tester.pumpWidget(const StudentApp());
    await tester.enterText(find.byKey(const Key('goalField')), 'Learn Flutter');
    await tester.tap(find.byKey(const Key('saveGoalButton')));
    await tester.pump();

    expect(find.text('Current goal: Learn Flutter'), findsOneWidget);
    expect(find.text('Goal saved.'), findsOneWidget);
  });
}
