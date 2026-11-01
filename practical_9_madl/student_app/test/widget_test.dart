
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:student_app/main.dart';

void main() {
  testWidgets('Student registration screen loads', (tester) async {
    final client = MockClient((_) async => http.Response('{}', 200));
    addTearDown(client.close);

    await tester.pumpWidget(StudentApp(client: client));

    expect(find.text('Student Firebase App'), findsOneWidget);
    expect(find.text('Student Registration'), findsOneWidget);
    expect(find.text('Aryan Anande  |  Roll No. 5024105'), findsOneWidget);
    expect(find.text('No student records yet.'), findsOneWidget);
  });

  testWidgets('Student can be saved and loaded from Firebase', (tester) async {
    final requests = <http.Request>[];
    final client = MockClient((request) async {
      requests.add(request);
      if (request.method == 'POST') {
        return http.Response('{"name":"student-1"}', 200);
      }
      return http.Response(
        '{"student-1":{"name":"Aryan","course":"Flutter"}}',
        200,
      );
    });
    addTearDown(client.close);

    await tester.pumpWidget(StudentApp(client: client));

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

    expect(requests.map((request) => request.method), ['POST', 'GET']);
    expect(requests.first.url.path, '/students.json');
    expect(find.text('Aryan'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Student saved successfully!'), findsOneWidget);
  });

  testWidgets('Empty form shows validation message', (tester) async {
    final client = MockClient((_) async {
      fail('Firebase should not be called for an empty form.');
    });
    addTearDown(client.close);

    await tester.pumpWidget(StudentApp(client: client));

    await tester.tap(find.byKey(const Key('addStudentButton')));
    await tester.pump();

    expect(find.text('Enter both name and course.'), findsOneWidget);
  });
}
