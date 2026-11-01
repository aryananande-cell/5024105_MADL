import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color _indigo = Color(0xFF3949AB);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Registration',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _indigo),
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String? branch;
  String gender = 'Male';
  bool hidePassword = true;

  void register() {
    if (!formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Registration Successful'),
        content: Text('Welcome, ${nameController.text.trim()}!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              reset();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void reset() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    setState(() {
      branch = null;
      gender = 'Male';
      hidePassword = true;
    });
    formKey.currentState?.reset();
  }

  String? requiredField(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final branches = [
      'Computer Engineering',
      'Information Technology',
      'Electronics',
      'Mechanical',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Registration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Icon(Icons.school, size: 70)),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Center(child: Text('Enter your details to register')),
                  const SizedBox(height: 5),
                  const Center(
                    child: Text(
                      'Aryan Anande  |  Roll No. 5024105',
                      style: TextStyle(color: Color(0xFF5C6278)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const _FieldLabel('Full Name'),
                  TextFormField(
                    key: const Key('fullNameField'),
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: _decoration('Enter your name', Icons.person),
                    validator: (value) =>
                        requiredField(value, 'Enter your name'),
                  ),
                  const SizedBox(height: 15),
                  const _FieldLabel('Email'),
                  TextFormField(
                    key: const Key('emailField'),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _decoration('example@gmail.com', Icons.email),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your email';
                      }
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                          .hasMatch(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const _FieldLabel('Phone Number'),
                  TextFormField(
                    key: const Key('phoneField'),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: _decoration('10-digit number', Icons.phone),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter phone number';
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const _FieldLabel('Branch'),
                  DropdownButtonFormField<String>(
                    key: const Key('branchField'),
                    initialValue: branch,
                    decoration: _decoration(null, Icons.school),
                    hint: const Text('Select branch'),
                    items: branches
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => branch = value),
                    validator: (value) =>
                        value == null ? 'Select your branch' : null,
                  ),
                  const SizedBox(height: 15),
                  const _FieldLabel('Gender'),
                  SegmentedButton<String>(
                    key: const Key('genderSelector'),
                    segments: const [
                      ButtonSegment(value: 'Male', label: Text('Male')),
                      ButtonSegment(value: 'Female', label: Text('Female')),
                    ],
                    selected: {gender},
                    onSelectionChanged: (selection) {
                      setState(() => gender = selection.first);
                    },
                  ),
                  const SizedBox(height: 15),
                  const _FieldLabel('Password'),
                  TextFormField(
                    key: const Key('passwordField'),
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: _decoration('Enter password', Icons.lock)
                        .copyWith(
                          suffixIcon: IconButton(
                            key: const Key('passwordVisibilityButton'),
                            tooltip: hidePassword
                                ? 'Show password'
                                : 'Hide password',
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () =>
                                setState(() => hidePassword = !hidePassword),
                          ),
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter password';
                      }
                      if (value.length < 6) return 'Minimum 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      key: const Key('registerButton'),
                      onPressed: register,
                      icon: const Icon(Icons.person_add),
                      label: const Text(
                        'REGISTER',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      key: const Key('resetButton'),
                      onPressed: reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('RESET'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String? hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
