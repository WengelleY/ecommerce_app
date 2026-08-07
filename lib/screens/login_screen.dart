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
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.shopping_bag, size: 90),

            const SizedBox(height: 30),

            TextField(
              controller: usernameController,

              decoration: const InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,

              obscureText: true,

              decoration: const InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 20),

            if (authProvider.errorMessage != null)
              Text(
                authProvider.errorMessage!,

                style: const TextStyle(color: Color(0xff8B5E3C)),
              ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: authProvider.isLoading
                    ? null
                    : () async {
                        await context.read<AuthProvider>().login(
                          usernameController.text,
                          passwordController.text,
                        );

                        if (authProvider.token != null) {
                          context.go('/home');
                        }
                      },

                child: authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
