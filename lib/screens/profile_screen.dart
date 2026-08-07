import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

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

    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),

          const SizedBox(height: 20),

          Text(
            "${user.firstName} ${user.lastName}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text("@${user.username}", style: const TextStyle(fontSize: 18)),

          const SizedBox(height: 10),

          Text(user.email),

          const SizedBox(height: 10),

          Text(user.phone),
        ],
      ),
    );
  }
}
