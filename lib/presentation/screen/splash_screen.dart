import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/routes/route_names.dart';

class SplashAuthScreen extends StatefulWidget {
  const SplashAuthScreen({super.key});

  @override
  State<SplashAuthScreen> createState() => _SplashAuthScreenState();
}

class _SplashAuthScreenState extends State<SplashAuthScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {
      context.go(RouteNames.home);
    } else {
      context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.primaryGreen,
        ),
      ),
    );
  }
}
