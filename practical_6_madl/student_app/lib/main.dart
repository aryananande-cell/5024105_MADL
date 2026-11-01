import 'package:flutter/material.dart';

const Color _forest = Color(0xFF176B4D);
const Color _page = Color(0xFFF4F8F5);

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitLife Center',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _forest),
        scaffoldBackgroundColor: _page,
        useMaterial3: true,
      ),
      home: const FitnessHome(),
    );
  }
}

class FitnessHome extends StatelessWidget {
  const FitnessHome({super.key});

  static const List<(String, double)> _workoutData = [
    ('Mon', 60),
    ('Tue', 100),
    ('Wed', 80),
    ('Thu', 120),
    ('Fri', 90),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FitLife Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: _forest,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to FitLife Center',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ARYAN ANANDE  |  ROLL NO. 5024105',
              style: TextStyle(
                color: Color(0xFF53665B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1400&q=85',
                height: 205,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 205,
                  width: double.infinity,
                  color: const Color(0xFFDCEAE0),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.fitness_center,
                    size: 52,
                    color: _forest,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
            const _SectionHeading('Workout Programs'),
            const SizedBox(height: 14),
            const Row(
              children: [
                Expanded(
                  child: _ProgramTile(
                    label: 'Strength',
                    icon: Icons.fitness_center,
                    color: Color(0xFFC84536),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _ProgramTile(
                    label: 'Cardio',
                    icon: Icons.directions_run,
                    color: Color(0xFFD47A20),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _ProgramTile(
                    label: 'Yoga',
                    icon: Icons.self_improvement,
                    color: _forest,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const _SectionHeading('Weekly Workout Statistics'),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE1E9E3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Workout Hours',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 144,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _workoutData
                          .map((item) => _WorkoutBar(item.$1, item.$2))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _forest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.card_membership,
                    color: Colors.white,
                    size: 34,
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join Our Fitness Program',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Start your fitness journey today',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Explore membership',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Ask at the front desk about membership.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
    );
  }
}

class _ProgramTile extends StatelessWidget {
  const _ProgramTile({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1E9E3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 34, color: color),
          const SizedBox(height: 7),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _WorkoutBar extends StatelessWidget {
  const _WorkoutBar(this.day, this.height);

  final String day;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: height,
          decoration: BoxDecoration(
            color: day == 'Thu' ? const Color(0xFFD47A20) : _forest,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 6),
        Text(day, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
