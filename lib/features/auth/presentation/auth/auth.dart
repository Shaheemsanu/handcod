import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handcode_test/features/auth/auth.dart';
import 'package:handcode_test/shared/shared.dart';

export 'auth_mobile.dart';
export 'auth_web.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: ResponsiveWidget(
        smallScreen: AuthScreenMobile(),
        largeScreen: AuthScreenWeb(),
      ),
    );
  }
}
