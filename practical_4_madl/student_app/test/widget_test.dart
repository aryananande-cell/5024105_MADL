import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/main.dart';

void main() {
  testWidgets('Registration form displays its fields', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Student Registration'), findsOneWidget);
    expect(find.text('Aryan Anande  |  Roll No. 5024105'), findsOneWidget);
    expect(find.byKey(const Key('fullNameField')), findsOneWidget);
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('branchField')), findsOneWidget);
  });

  testWidgets('Empty registration shows field validation', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.ensureVisible(find.byKey(const Key('registerButton')));
    await tester.tap(find.byKey(const Key('registerButton')));
    await tester.pumpAndSettle();

    expect(find.text('Enter your name'), findsNWidgets(2));
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter phone number'), findsOneWidget);
    expect(find.text('Select your branch'), findsOneWidget);
    expect(find.text('Enter password'), findsNWidgets(2));
  });

  testWidgets('Valid registration shows success dialog and resets form', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byKey(const Key('fullNameField')), 'Aryan');
    await tester.enterText(
      find.byKey(const Key('emailField')),
      'aryan@example.com',
    );
    await tester.enterText(find.byKey(const Key('phoneField')), '1234567890');
    await tester.enterText(find.byKey(const Key('passwordField')), 'secure123');
    await tester.ensureVisible(find.byKey(const Key('branchField')));
    await tester.tap(find.byKey(const Key('branchField')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Information Technology').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('registerButton')));
    await tester.tap(find.byKey(const Key('registerButton')));
    await tester.pumpAndSettle();

    expect(find.text('Registration Successful'), findsOneWidget);
    expect(find.text('Welcome, Aryan!'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your name'), findsOneWidget);
  });
}
