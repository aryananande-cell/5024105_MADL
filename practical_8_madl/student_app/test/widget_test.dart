import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:student_app/main.dart';

Widget buildNotesApp() {
  return ChangeNotifierProvider(
    create: (_) => NoteData(),
    child: const NotesApp(),
  );
}

void main() {
  testWidgets('Notes screen shows student and initial memory', (tester) async {
    await tester.pumpWidget(buildNotesApp());

    expect(find.text('Personal Notes'), findsOneWidget);
    expect(find.text('Aryan Anande  |  Roll No. 5024105'), findsOneWidget);
    expect(find.text('No note saved yet.'), findsOneWidget);
  });

  testWidgets('Saving a note updates the memory buffer', (tester) async {
    await tester.pumpWidget(buildNotesApp());
    await tester.enterText(find.byKey(const Key('noteField')), 'Study Flutter');
    await tester.tap(find.byKey(const Key('saveNoteButton')));
    await tester.pump();

    expect(find.text('Study Flutter'), findsOneWidget);
    expect(find.text('Note updated in memory'), findsOneWidget);
  });

  testWidgets('Clear resets the note buffer', (tester) async {
    await tester.pumpWidget(buildNotesApp());
    await tester.enterText(find.byKey(const Key('noteField')), 'Study Flutter');
    await tester.tap(find.byKey(const Key('saveNoteButton')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('clearNoteButton')));
    await tester.pump();

    expect(find.text('No note saved yet.'), findsOneWidget);
    expect(find.text('Note cleared'), findsOneWidget);
  });

  testWidgets('Empty note is not saved', (tester) async {
    await tester.pumpWidget(buildNotesApp());
    await tester.tap(find.byKey(const Key('saveNoteButton')));
    await tester.pump();

    expect(find.text('Please enter a note'), findsOneWidget);
    expect(find.text('No note saved yet.'), findsOneWidget);
  });
}
