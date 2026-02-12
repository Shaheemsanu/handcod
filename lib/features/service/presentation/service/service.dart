import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handcode_test/features/service/service.dart';
import 'package:handcode_test/shared/shared.dart';

export 'service_mobile.dart';
export 'service_web.dart';

class ServiceScreen extends ConsumerWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ResponsiveWidget(
        smallScreen: ServiceScreenMobile(),
        largeScreen: const ServiceScreenWeb(),
      ),
    );
  }
}
