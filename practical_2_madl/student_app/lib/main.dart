import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF315CA8);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      home: const HelloHome(),
    );
  }
}

class HelloHome extends StatelessWidget {
  const HelloHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello Flutter 👋',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FlutterLogo(size: 120),
                const SizedBox(height: 30),
                const Text(
                  'Hello World!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to my first Flutter app',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Aryan Anande  |  Roll No. 5024105',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF536174)),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  key: const Key('getStartedButton'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Welcome to Flutter!')),
                    );
                  },
                  icon: const Icon(Icons.rocket_launch),
                  label: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
