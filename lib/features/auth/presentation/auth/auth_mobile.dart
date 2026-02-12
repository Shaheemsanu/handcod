import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancod_theme/colors.dart';
import 'package:hancod_theme/forms.dart';
import 'package:handcode_test/features/auth/controller/auth/auth_notifier.dart';
import 'package:handcode_test/shared/widgets/custom_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthScreenMobile extends ConsumerStatefulWidget {
  const AuthScreenMobile({super.key});

  @override
  ConsumerState<AuthScreenMobile> createState() => _AuthScreenMobileState();
}

class _AuthScreenMobileState extends ConsumerState<AuthScreenMobile> {
  final _inputDecoration = const InputDecoration(
    labelText: 'Enter Mail',

    border: OutlineInputBorder(),
  );

  Future<void> login() async {
    log("1-${ref.watch(authNotifierProvider).status}");
    await ref.read(authNotifierProvider.notifier).signIn();
    log("2-${ref.watch(authNotifierProvider).status}");
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider.notifier);
    return ReactiveForm(
      formGroup: authState.form,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              _buildLogo(),
              const Spacer(flex: 1),

              CommonButton(
                text: 'Continue with Google',
                backgroundColor: AppColors.googleBg,
                textColor: AppColors.textBlack,
                icon: const Icon(Icons.g_mobiledata),
                onPressed: () async {
                  try {
                    // UserCredential? userCred = await authService
                    //     .signInWithGoogle();
                    // log("$userCred");

                    // if (userCred == null) {
                    //   if (!context.mounted) return;
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text("Google Sign-In Failed")),
                    //   );
                    // }

                    await login();
                    if (!context.mounted) return;
                    // context.goNamed(AppRouter.home);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Google Sign-In Failed: $e")),
                    );
                  }
                },
              ),

              const SizedBox(height: 12),
              ReactiveText<String>(
                formControlName: 'email',
                label: "Email",
                decoration: _inputDecoration,
              ),
              const SizedBox(height: 12),
              ReactiveText<String>(
                formControlName: 'password',
                label: "Password",
                keyboardType: TextInputType.phone,

                // decoration: _inputDecoration,
              ),
              const SizedBox(height: 12),
              CommonButton(
                text: 'Continue with Phone',
                backgroundColor: AppColors.primaryGreen,
                textColor: AppColors.textWhite,
                onPressed: () {
                  // context.push(AppRouter.home);
                  login();
                },
              ),
              const SizedBox(height: 12),
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
