import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handcode_test/features/cart/cart.dart';
import 'package:handcode_test/shared/shared.dart';

export 'cart_mobile.dart';
export 'cart_web.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: ResponsiveWidget(
        smallScreen: CartScreenMobile(),
        largeScreen: CartScreenWeb(),
      ),
    );
  }
}
