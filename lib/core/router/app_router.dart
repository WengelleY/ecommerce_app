import 'package:go_router/go_router.dart';
import '../../models/product.dart';
import '../../screens/login_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/product_details_screen.dart';
import '../../screens/cart_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/intro_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',

  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),

    GoRoute(
      path: '/product',

      builder: (context, state) {
        final product = state.extra as Product;

        return ProductDetailsScreen(product: product);
      },
    ),

    GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
    GoRoute(
      path: '/profile',

      builder: (context, state) {
        return const ProfileScreen();
      },
    ),
  ],
);
