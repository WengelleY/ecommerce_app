import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<UserProvider>().fetchUser(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: _buildBody(userProvider),
    );
  }

  Widget _buildBody(UserProvider userProvider) {
    if (userProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userProvider.errorMessage != null) {
      return Center(child: Text(userProvider.errorMessage!));
    }

    if (userProvider.user == null) {
      return const Center(child: Text("No user data"));
    }

    final user = userProvider.user!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(radius: 55, child: Icon(Icons.person, size: 60)),

            const SizedBox(height: 20),

            Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text("@${user.username}", style: const TextStyle(fontSize: 17)),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: const Text("Email"),
                      subtitle: Text(user.email),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.phone_outlined),
                      title: const Text("Phone"),
                      subtitle: Text(user.phone),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () async {
                  await context.read<AuthProvider>().logout();

                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                icon: const Icon(Icons.logout),

                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
