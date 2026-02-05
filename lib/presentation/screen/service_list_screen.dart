import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/providers/cart_provider.dart';
import 'package:handcode_test/core/services/cart_service.dart';
import 'package:handcode_test/presentation/models/service_model.dart';
import 'package:handcode_test/presentation/widgets/categor_tabs.dart';
import 'package:handcode_test/presentation/widgets/checkout_bar.dart';
import 'package:handcode_test/presentation/widgets/service_list_item.dart';

class ServiceListScreen extends ConsumerWidget {
  ServiceListScreen({super.key});

  final ValueNotifier<String> selectedCategory = ValueNotifier("Deep cleaning");

  final CartService cartService = CartService();

  final List<ServiceModel> allServices = [
    ServiceModel(
      name: "Home Deep Clean",
      category: "Deep cleaning",
      rating: 4.5,
      orders: 120,
      duration: "120 Minutes",
      price: 1999,
      quantity: 2,
    ),
    ServiceModel(
      name: "Kitchen Deep Clean",
      category: "Deep cleaning",
      rating: 4.3,
      orders: 98,
      duration: "90 Minutes",
      price: 1299,
      quantity: 0,
    ),

    ServiceModel(
      name: "Daily Maid",
      category: "Maid Services",
      rating: 4.2,
      orders: 210,
      duration: "8 Hours",
      price: 799,
      quantity: 0,
    ),
    ServiceModel(
      name: "Weekly Maid",
      category: "Maid Services",
      rating: 4.4,
      orders: 160,
      duration: "8 Hours",
      price: 3499,
      quantity: 0,
    ),

    ServiceModel(
      name: "Interior Car Cleaning",
      category: "Car Cleaning",
      rating: 4.1,
      orders: 75,
      duration: "45 Minutes",
      price: 599,
      quantity: 0,
    ),
    ServiceModel(
      name: "Exterior Car Cleaning",
      category: "Car Cleaning",
      rating: 4.0,
      orders: 62,
      duration: "30 Minutes",
      price: 399,
      quantity: 0,
    ),

    ServiceModel(
      name: "Small Carpet Wash",
      category: "Carpet Cleaning",
      rating: 4.3,
      orders: 54,
      duration: "40 Minutes",
      price: 499,
      quantity: 0,
    ),
    ServiceModel(
      name: "Large Carpet Wash",
      category: "Carpet Cleaning",
      rating: 4.6,
      orders: 89,
      duration: "60 Minutes",
      price: 899,
      quantity: 0,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Cleaning Services",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedCategory,
                  builder: (context, value, child) {
                    return CategoryTabs(
                      categories: [
                        "Deep cleaning",
                        "Maid Services",
                        "Car Cleaning",
                        "Carpet Cleaning",
                      ],
                      selectedCategory: selectedCategory,
                    );
                  },
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedCategory,
                  builder: (context, selectedCat, _) {
                    final services = allServices
                        .where((service) => service.category == selectedCat)
                        .toList();

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return ServiceListItem(service: services[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          if (cart.items.isNotEmpty)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: CheckOutBar(
                summaryText:
                    "${notifier.totalItems} items  |  ₹${notifier.totalPrice.toStringAsFixed(0)}",
                buttonText: cart.isLoading ? "ADDING..." : "VIEW CART",
                isLoading: cart.isLoading,
                onPressed: cart.isLoading
                    ? () {}
                    : () async {
                        final success = await notifier.syncCartToServer();

                        if (success && context.mounted) {
                          context.push('/cart');
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Add to cart failed")),
                            );
                          }
                        }
                      },
              ),
            ),
        ],
      ),
    );
  }
}
