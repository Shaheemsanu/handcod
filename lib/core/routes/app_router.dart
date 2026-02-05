
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/routes/route_names.dart';
import 'package:handcode_test/presentation/screen/account_screen.dart';
import 'package:handcode_test/presentation/screen/bookings_screen.dart';
import 'package:handcode_test/presentation/screen/cart_screen.dart';
import 'package:handcode_test/presentation/screen/home_screen.dart';
import 'package:handcode_test/presentation/screen/login_screen.dart';
import 'package:handcode_test/presentation/screen/main_nav_screen.dart';
import 'package:handcode_test/presentation/screen/phone_auth_screen.dart';
import 'package:handcode_test/presentation/screen/service_list_screen.dart';
import 'package:handcode_test/presentation/screen/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashAuthScreen(),
      ),

      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.phoneAuth,
        builder: (context, state) => const PhoneAuthScreen(),
      ),
      GoRoute(
        path: RouteNames.services,
        builder: (context, state) => ServiceListScreen(),
      ),

      GoRoute(
        path: RouteNames.cart,
        builder: (context, state) => const CartScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MainNavScreen(child: child);
        },
        routes: [
          GoRoute(
            path: RouteNames.home,
            builder: (context, state) => const HomeScreen(),
          ),

          GoRoute(
            path: RouteNames.bookings,
            builder: (context, state) => const BookingsScreen(),
          ),

          GoRoute(
            path: RouteNames.account,
            builder: (context, state) => const AccountScreen(),
          ),
        ],
      ),
    ],
  );
}
