import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();

  await authProvider.loadToken();

  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),

        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: "E-Commerce App",

        home: authProvider.token != null
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }
}
