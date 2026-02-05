import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/providers/cart_state.dart';

class CartItemsList extends ConsumerWidget {
  const CartItemsList({super.key, required this.cartState});

  final CartState cartState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return cartState.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: List.generate(cartState.items.length, (index) {
              final item = cartState.items[index];

              return cartItemRow(
                number: "${index + 1}",
                title: item.name,
                price: item.price.toString(),
                quantity: item.quantity,
              );
            }),
          );
  }

  Widget cartItemRow({
    required String number,
    required String title,
    required String price,
    required int quantity,
    VoidCallback? onAdd,
    VoidCallback? onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            "$number. ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
          _smallStepper(quantity: quantity, onAdd: onAdd, onRemove: onRemove),
          const SizedBox(width: 15),
          Text(
            "₹$price",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallStepper({
    required int quantity,
    VoidCallback? onAdd,
    VoidCallback? onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onRemove,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkGreyStepper,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.remove, color: AppColors.white, size: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("$quantity"),
          ),
          InkWell(
            onTap: onAdd,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkGreyStepper,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.add, color: AppColors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
