// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/main.dart';

void main() {
  testWidgets('FitLife dashboard displays its main sections', (tester) async {
    await tester.pumpWidget(const FitnessApp());

    expect(find.text('FitLife Center'), findsOneWidget);
    expect(find.text('ARYAN ANANDE  |  ROLL NO. 5024105'), findsOneWidget);
    expect(find.text('Workout Programs'), findsOneWidget);
    expect(find.text('Weekly Workout Statistics'), findsOneWidget);
    expect(find.text('Join Our Fitness Program'), findsOneWidget);
  });
}
