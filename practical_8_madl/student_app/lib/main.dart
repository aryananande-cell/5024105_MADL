import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color _indigo = Color(0xFF3F51B5);
const Color _background = Color(0xFFF4F6FC);

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => NoteData(), child: const NotesApp()),
  );
}

class NoteData extends ChangeNotifier {
  String _savedNote = 'No note saved yet.';

  String get savedNote => _savedNote;

  void updateNote(String note) {
    _savedNote = note;
    notifyListeners();
  }

  void resetNote() {
    _savedNote = 'No note saved yet.';
    notifyListeners();
  }
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _indigo),
        scaffoldBackgroundColor: _background,
      ),
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController controller = TextEditingController();

  void saveNote() {
    final note = controller.text.trim();
    if (note.isEmpty) {
      showMessage('Please enter a note');
      return;
    }

    context.read<NoteData>().updateNote(note);
    showMessage('Note updated in memory');
  }

  void clearNote() {
    controller.clear();
    context.read<NoteData>().resetNote();
    showMessage('Note cleared');
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.note_alt, size: 75, color: _indigo),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Aryan Anande  |  Roll No. 5024105',
                    style: TextStyle(color: Color(0xFF596174)),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  key: const Key('noteField'),
                  controller: controller,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Type your note here...',
                    alignLabelWithHint: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 88),
                      child: Icon(Icons.edit),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _ActionButton(
                  key: const Key('saveNoteButton'),
                  label: 'SAVE TO MEMORY',
                  icon: Icons.save,
                  onPressed: saveNote,
                ),
                const SizedBox(height: 10),
                _ActionButton(
                  key: const Key('clearNoteButton'),
                  label: 'CLEAR',
                  icon: Icons.delete,
                  onPressed: clearNote,
                  isOutlined: true,
                ),
                const SizedBox(height: 28),
                const Text(
                  'Current Memory Buffer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9ECF8),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFC5CAE9)),
                  ),
                  child: Consumer<NoteData>(
                    builder: (context, data, _) => Text(
                      data.savedNote,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isOutlined = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: isOutlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(label),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: _indigo,
              ),
            ),
    );
  }
}
