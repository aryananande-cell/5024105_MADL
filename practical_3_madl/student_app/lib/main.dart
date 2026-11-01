import 'package:flutter/material.dart';

const Color _green = Color(0xFF2E6B58);
const Color _background = Color(0xFFF3F7F4);

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _green),
        scaffoldBackgroundColor: _background,
        useMaterial3: true,
      ),
      home: const StudentProfile(),
    );
  }
}

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final goalController = TextEditingController();
  String savedGoal = '';

  void saveGoal() {
    final goal = goalController.text.trim();
    if (goal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a goal before saving.')),
      );
      return;
    }

    setState(() => savedGoal = goal);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Goal saved.')));
  }

  @override
  void dispose() {
    goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Profile',
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
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _green, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: const Color(0xFFDCE9E0),
                    child: ClipOval(
                      child: Image.network(
                        'https://i.pravatar.cc/300?img=12',
                        fit: BoxFit.cover,
                        width: 130,
                        height: 130,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, size: 65, color: _green),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Aryan Anande',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Information Technology Student',
                  style: TextStyle(fontSize: 16, color: Color(0xFF59665E)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Roll No. 5024105',
                  style: TextStyle(fontSize: 14, color: Color(0xFF59665E)),
                ),
                const SizedBox(height: 25),
                const Row(
                  children: [
                    Expanded(
                      child: InfoItem(
                        icon: Icons.school,
                        title: 'Semester',
                        value: '5th',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InfoItem(
                        icon: Icons.star,
                        title: 'CGPA',
                        value: '8.84',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InfoItem(
                        icon: Icons.assignment,
                        title: 'Projects',
                        value: '12',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                TextField(
                  key: const Key('goalField'),
                  controller: goalController,
                  decoration: InputDecoration(
                    labelText: 'Enter your goal',
                    hintText: 'e.g. Learn Flutter',
                    prefixIcon: const Icon(Icons.edit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    key: const Key('saveGoalButton'),
                    onPressed: saveGoal,
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Save Goal',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                if (savedGoal.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4EFE7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Current goal: $savedGoal'),
                  ),
                ],
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFDCE5DE)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb, color: _green),
                          SizedBox(width: 10),
                          Text(
                            'Today\'s Motivation',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Keep learning, keep building, and '
                        'keep improving every day!',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
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

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: _green),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}
