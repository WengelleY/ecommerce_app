import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            TextField(
              controller: usernameController,

              decoration: const InputDecoration(labelText: "Username"),
            ),

            TextField(
              controller: passwordController,

              obscureText: true,

              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20),

            // Error message
            if (authProvider.errorMessage != null)
              Text(authProvider.errorMessage!),

            ElevatedButton(
              onPressed: authProvider.isLoading
                  ? null
                  : () async {
                      await context.read<AuthProvider>().login(
                        usernameController.text,
                        passwordController.text,
                      );

                      if (authProvider.token != null) {
                        context.pushReplacement('/home');
                      }
                    },

              child: authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
