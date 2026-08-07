import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/user_provider.dart';
import 'core/router/app_router.dart';
import 'providers/CartProvider.dart';
import 'core/theme/app_theme.dart';

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

        ChangeNotifierProvider(create: (_) => CartProvider()..loadCart()),

        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        title: "E-Commerce App",
        routerConfig: appRouter,
      ),
    );
  }
}
