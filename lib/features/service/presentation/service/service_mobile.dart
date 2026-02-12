import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/colors.dart';
import 'package:handcode_test/features/service/controller/service/service_notifier.dart';
import 'package:handcode_test/features/service/presentation/service/widget/categor_tabs.dart';
import 'package:handcode_test/features/service/presentation/service/widget/checkout_bar.dart';
import 'package:handcode_test/features/service/presentation/service/widget/service_list_item.dart';
import 'package:handcode_test/shared/utils/router.dart';

class ServiceModelUI {
  final String name;
  final String category;
  final double rating;
  final int orders;
  final String duration;
  final int price;
  final String? imageUrl;
  final int quantity;

  ServiceModelUI({
    required this.name,
    required this.category,
    required this.rating,
    required this.orders,
    required this.duration,
    required this.price,
    this.imageUrl,
    this.quantity = 0,
  });

  factory ServiceModelUI.fromMap(Map<String, dynamic> map) {
    return ServiceModelUI(
      duration: "",
      imageUrl: "",
      category: "",
      rating: 0,
      orders: 0,
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'quantity': quantity, 'price': price};
  }

  ServiceModelUI copyWith({int? quantity}) {
    return ServiceModelUI(
      name: name,
      category: category,
      rating: rating,
      orders: orders,
      duration: duration,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ServiceScreenMobile extends ConsumerWidget {
  ServiceScreenMobile({super.key});

  final ValueNotifier<String> selectedCategory = ValueNotifier("Deep cleaning");

  // final CartService cartService = CartService();

  final List<ServiceModelUI> allServices = [
    ServiceModelUI(
      name: "Home Deep Clean",
      category: "Deep cleaning",
      rating: 4.5,
      orders: 120,
      duration: "120 Minutes",
      price: 1999,
      quantity: 2,
    ),
    ServiceModelUI(
      name: "Kitchen Deep Clean",
      category: "Deep cleaning",
      rating: 4.3,
      orders: 98,
      duration: "90 Minutes",
      price: 1299,
      quantity: 0,
    ),

    ServiceModelUI(
      name: "Daily Maid",
      category: "Maid Services",
      rating: 4.2,
      orders: 210,
      duration: "8 Hours",
      price: 799,
      quantity: 0,
    ),
    ServiceModelUI(
      name: "Weekly Maid",
      category: "Maid Services",
      rating: 4.4,
      orders: 160,
      duration: "8 Hours",
      price: 3499,
      quantity: 0,
    ),

    ServiceModelUI(
      name: "Interior Car Cleaning",
      category: "Car Cleaning",
      rating: 4.1,
      orders: 75,
      duration: "45 Minutes",
      price: 599,
      quantity: 0,
    ),
    ServiceModelUI(
      name: "Exterior Car Cleaning",
      category: "Car Cleaning",
      rating: 4.0,
      orders: 62,
      duration: "30 Minutes",
      price: 399,
      quantity: 0,
    ),

    ServiceModelUI(
      name: "Small Carpet Wash",
      category: "Carpet Cleaning",
      rating: 4.3,
      orders: 54,
      duration: "40 Minutes",
      price: 499,
      quantity: 0,
    ),
    ServiceModelUI(
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
    final serviceAsync = ref.watch(serviceNotifierProvider);
    // final cart = ref.watch(cartProvider);
    final notifier = ref.watch(serviceNotifierProvider.notifier);
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
      body: SafeArea(
        child: Stack(
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
                      // final services = allServices
                      //     .where((service) => service.category == selectedCat)
                      //     .toList();

                      return serviceAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(child: Text(e.toString())),
                        data: (state) {
                          return ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 16,
                              bottom: 180,
                              right: 16,
                              top: 16,
                            ),
                            itemCount: state.services.length,
                            itemBuilder: (context, index) {
                              return ServiceListItem(
                                service: state.services[index],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // if (cart.items.isNotEmpty)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: CheckOutBar(
                summaryText:
                    "${notifier.totalItems} items  |  ₹${notifier.totalPrice.toStringAsFixed(0)}",
                buttonText: "VIEW CART",
                isLoading: false, //cart.isLoading,
                onPressed: () {
                  if (context.mounted) {
                    context.pushNamed(AppRouter.cart);
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
      ),
    );
  }
}
