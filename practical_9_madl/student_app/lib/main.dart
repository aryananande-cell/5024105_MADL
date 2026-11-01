
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String databaseUrl =
    'https://flutterfirebasedemo-3fd24-default-rtdb.firebaseio.com';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key, this.client});

  final http.Client? client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Student App',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: StudentHome(client: client),
    );
  }
}

class StudentHome extends StatefulWidget {
  const StudentHome({super.key, this.client});

  final http.Client? client;

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  late final http.Client _client;
  late final bool _ownsClient;
  Map<String, dynamic> students = {};
  bool loading = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    _ownsClient = widget.client == null;
    _client = widget.client ?? http.Client();
  }

  Future<void> saveStudent() async {
    final name = nameController.text.trim();
    final course = courseController.text.trim();

    if (name.isEmpty || course.isEmpty) {
      setState(() => message = 'Enter both name and course.');
      return;
    }

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final response = await _client.post(
        Uri.parse('$databaseUrl/students.json'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'course': course}),
      );

      if (response.statusCode == 200) {
        nameController.clear();
        courseController.clear();
        await loadStudents();
        if (mounted) setState(() => message = 'Student saved successfully!');
      } else if (mounted) {
        setState(() => message =
            'Save failed: ${response.statusCode} ${response.body}');
      }
    } catch (error) {
      if (mounted) setState(() => message = 'Error: $error');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> loadStudents() async {
    if (!mounted) return;
    setState(() => loading = true);

    try {
      final response = await _client.get(
        Uri.parse('$databaseUrl/students.json'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            students =
                data == null ? {} : Map<String, dynamic>.from(data as Map);
            message = 'Database loaded successfully.';
          });
        }
      } else if (mounted) {
        setState(() => message =
            'Read failed: ${response.statusCode} ${response.body}');
      }
    } catch (error) {
      if (mounted) setState(() => message = 'Error: $error');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    if (_ownsClient) _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Firebase App'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: loading ? null : loadStudents,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh records',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.school, size: 65, color: Colors.indigo),
          const SizedBox(height: 8),
          const Text(
            'Student Registration',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Aryan Anande  |  Roll No. 5024105',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            key: const Key('nameField'),
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Student Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('courseField'),
            controller: courseController,
            decoration: const InputDecoration(
              labelText: 'Course',
              prefixIcon: Icon(Icons.book),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          FilledButton.icon(
            key: const Key('addStudentButton'),
            onPressed: loading ? null : saveStudent,
            icon: const Icon(Icons.cloud_upload),
            label: const Text('Save to Firebase'),
          ),
          OutlinedButton.icon(
            onPressed: loading ? null : loadStudents,
            icon: const Icon(Icons.download),
            label: const Text('Read from Firebase'),
          ),
          if (loading) const Center(child: CircularProgressIndicator()),
          if (message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(message, textAlign: TextAlign.center),
            ),
          const Divider(height: 30),
          const Text(
            'Saved Students',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (students.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No student records yet.',
                textAlign: TextAlign.center,
              ),
            ),
          ...students.entries.map((entry) {
            final student = Map<String, dynamic>.from(entry.value as Map);
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text('${student['name'] ?? ''}'),
                subtitle: Text('${student['course'] ?? ''}'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
