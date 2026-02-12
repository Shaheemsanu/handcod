import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hancod_theme/colors.dart';
import 'package:handcode_test/features/service/controller/service/service_notifier.dart';
import 'package:handcode_test/features/service/domain/models/servicemodel/servicemodel_model.dart';
import 'package:handcode_test/shared/shared.dart';
import 'package:handcode_test/shared/utils/assets.gen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ServiceListItem extends ConsumerWidget {
  final Servicemodel service;

  const ServiceListItem({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(serviceNotifierProvider.notifier);
    final itemForm = FormGroup({
      'id': FormControl<int>(value: service.id ?? 0, nonNullable: true),
      'quantity': FormControl<int>(value: service.quantity, nonNullable: true),
    });
    final quantityControl = itemForm.control('quantity') as FormControl<int>;

    void updateItemQuantity(int delta) {
      final current = quantityControl.value;
      final stock = service.stock ?? 0;
      final attempted = (current ?? 0) + delta;
      final next = attempted.clamp(0, stock);

      if (attempted > stock) {
        Alert.error("Out of stock! Maximum available: $stock");
      }

      if (next == current) return;

      quantityControl.updateValue(next);
      notifier.updateQuantity(service.id ?? 0, next);
    }

    return ReactiveForm(
      formGroup: itemForm,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildImage(),
                  const SizedBox(width: 12),
                  Expanded(child: _buildDetails()),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ReactiveValueListenableBuilder<int>(
                formControl: quantityControl,
                builder: (context, control, child) {
                  return (control.value! > 0)
                      ? _buildQuantityToggle(
                          quantityControl: quantityControl,
                          onIncrement: () => updateItemQuantity(1),
                          onDecrement: () => updateItemQuantity(-1),
                        )
                      : _buildAddButton(onTap: () => updateItemQuantity(1));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: service.image != null
          ? Image.network(
              service.image.toString(),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            )
          : Image.asset(
              Assets.images.bathroomCleaning.path,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.star, color: AppColors.ratingYellow, size: 16),
            Text(
              " (4.5/5) ${service.order ?? ""} Orders",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Text(
          service.name ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Text(
          "90 Minutes",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          "\u20B9 ${(service.price ?? 0).toStringAsFixed(2)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
          ),
        ),
        child: const Text(
          'Add  +',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityToggle({
    required FormControl<int> quantityControl,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onDecrement,
            icon: const Icon(
              Icons.remove,
              size: 18,
              color: AppColors.primaryGreen,
            ),
          ),
          Text(
            "${quantityControl.value}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: const Icon(
              Icons.add,
              size: 18,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}
