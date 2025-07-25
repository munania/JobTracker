import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker_app/src/features/authentication/data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class LoginScreen extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authRepositoryProvider).signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authRepositoryProvider).signInWithGoogle();
              },
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
