import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _careerGoalController = TextEditingController();
  final _preferredRolesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Tell us about your career goals'),
            TextField(
              controller: _careerGoalController,
              decoration: InputDecoration(labelText: 'Career Goal'),
            ),
            TextField(
              controller: _preferredRolesController,
              decoration: InputDecoration(labelText: 'Preferred Roles (comma-separated)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save onboarding data
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
