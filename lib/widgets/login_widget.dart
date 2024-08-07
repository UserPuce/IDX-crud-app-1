import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/login_provider.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  ref.read(loginProvider.notifier).login(username, password);
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
