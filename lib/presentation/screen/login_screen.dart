import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/common_widgets/custom_button.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/constants/sizes.dart';
import 'package:handcode_test/core/routes/route_names.dart';
import 'package:handcode_test/core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.horizontalPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildLogo(),
              const Spacer(flex: 3),

              CommonButton(
                text: 'Continue with Google',
                backgroundColor: AppColors.googleBg,
                textColor: AppColors.textBlack,
                icon: const Icon(Icons.g_mobiledata),
                onPressed: () async {
                  try {
                    UserCredential? userCred = await authService
                        .signInWithGoogle();
                    log("$userCred");

                    if (userCred == null) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Google Sign-In Failed")),
                      );
                    }
                    if (!context.mounted) return;
                    context.go(RouteNames.home);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Google Sign-In Failed: $e")),
                    );
                  }
                },
              ),

              const SizedBox(height: 12),

              CommonButton(
                text: 'Continue with Phone',
                backgroundColor: AppColors.primaryGreen,
                textColor: AppColors.textWhite,
                onPressed: () {
                  context.push(RouteNames.phoneAuth);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'Logo',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
