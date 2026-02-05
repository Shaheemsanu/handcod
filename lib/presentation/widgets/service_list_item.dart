import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handcode_test/core/constants/assets.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/constants/sizes.dart';
import 'package:handcode_test/core/providers/cart_provider.dart';
import 'package:handcode_test/presentation/models/service_model.dart';

class ServiceListItem extends ConsumerWidget {
  final ServiceModel service;

  const ServiceListItem({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    final cartItem = cart.items
        .where((e) => e.name == service.name)
        .cast<ServiceModel?>()
        .firstWhere((e) => true, orElse: () => null);

    final quantity = cartItem?.quantity ?? 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
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
                // service.isAdded ? _buildQuantityToggle() : _buildAddButton(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: quantity > 0
                ? _buildQuantityToggle(ref, quantity)
                : _buildAddButton(ref),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: service.imageUrl != null
          ? Image.network(
              service.imageUrl!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            )
          : Image.asset(
              AppImages.bathroomCleaning,
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
              " (${service.rating}/5) ${service.orders} Orders",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Text(
          service.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          service.duration,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          "₹ ${service.price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(cartProvider.notifier).addService(service);
      },
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
            topLeft: Radius.circular(AppSizes.cardRadius),
            bottomRight: Radius.circular(AppSizes.cardRadius),
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

  Widget _buildQuantityToggle(WidgetRef ref, int quantity) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              ref.read(cartProvider.notifier).removeService(service);
            },
            icon: const Icon(
              Icons.remove,
              size: 18,
              color: AppColors.primaryGreen,
            ),
          ),
          Text(
            "$quantity",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              ref.read(cartProvider.notifier).addService(service);
            },
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
