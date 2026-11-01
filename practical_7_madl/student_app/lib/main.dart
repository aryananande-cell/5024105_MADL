import 'package:flutter/material.dart';

const Color _indigo = Color(0xFF3949AB);

void main() {
  runApp(const StudentTaskApp());
}

class StudentTaskApp extends StatelessWidget {
  const StudentTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Task Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _indigo),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

class StudentTask {
  StudentTask({
    required this.title,
    required this.subject,
    required this.icon,
    this.done = false,
  });

  final String title;
  final String subject;
  final IconData icon;
  bool done;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<StudentTask> tasks = [
    StudentTask(
      title: 'Flutter Assignment',
      subject: 'Mobile Application Development',
      icon: Icons.phone_android,
    ),
    StudentTask(
      title: 'Software Engineering Lab',
      subject: 'Software Engineering',
      icon: Icons.code,
    ),
    StudentTask(
      title: 'Database Project',
      subject: 'DBMS',
      icon: Icons.storage,
    ),
  ];

  void showOptions(StudentTask task) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(task.done ? Icons.undo : Icons.check),
              title: Text(
                task.done ? 'Mark as incomplete' : 'Mark as completed',
              ),
              onTap: () {
                setState(() => task.done = !task.done);
                Navigator.pop(sheetContext);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Delete task'),
              onTap: () {
                setState(() => tasks.remove(task));
                Navigator.pop(sheetContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  void toggleTask(StudentTask task) {
    setState(() => task.done = !task.done);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(task.done ? 'Task completed' : 'Task marked incomplete'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            key: const Key('profileButton'),
            tooltip: 'Open profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, Aryan! 👋',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text('Manage your academic tasks easily.'),
            const SizedBox(height: 5),
            const Text(
              'Roll No. 5024105',
              style: TextStyle(color: Color(0xFF626779)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Tasks',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text('No tasks yet.'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return GestureDetector(
                          key: Key('task-$index'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => TaskDetailsScreen(
                                  title: task.title,
                                  subject: task.subject,
                                ),
                              ),
                            );
                          },
                          onDoubleTap: () => toggleTask(task),
                          onLongPress: () => showOptions(task),
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFFE6E9FA),
                                child: Icon(task.icon, color: _indigo),
                              ),
                              title: Text(
                                task.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: task.done
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Text(task.subject),
                              trailing: Icon(
                                task.done
                                    ? Icons.check_circle
                                    : Icons.arrow_forward_ios,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add task',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New task feature selected')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    super.key,
    required this.title,
    required this.subject,
  });

  final String title;
  final String subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.assignment_outlined, size: 80),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(subject, style: const TextStyle(fontSize: 17)),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Tasks'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xFFE6E9FA),
                child: Icon(Icons.person, size: 60, color: _indigo),
              ),
              const SizedBox(height: 20),
              const Text(
                'Aryan Anande',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('Information Technology Student'),
              const SizedBox(height: 4),
              const Text('Roll No. 5024105'),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
