import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handcode_test/core/constants/assets.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/providers/cart_provider.dart';
import 'package:handcode_test/core/providers/cart_state.dart';
import 'package:handcode_test/presentation/widgets/bill_row.dart';
import 'package:handcode_test/presentation/widgets/cart_items_list.dart';
import 'package:handcode_test/presentation/widgets/checkout_bar.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text("Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartItemsList(cartState: cartState),

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Add more Services",
                    style: TextStyle(color: AppColors.primaryGreen),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  "Frequently added services",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                _buildHorizontalSuggestions(),

                const SizedBox(height: 20),
                _buildCouponSection(
                  controller: TextEditingController(),
                  onApply: () {},
                ),

                const SizedBox(height: 14),
                buildWalletInfoTile(balance: "125", redeemAmount: "10"),

                const SizedBox(height: 20),
                _buildBillDetails(
                  cartState: cartState,
                  cartNotifier: cartNotifier,
                ),

                const SizedBox(height: 140),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: CheckOutBar(
              summaryText:
                  "Grand Total  |  ₹${cartNotifier.totalPrice.toStringAsFixed(0)}",
              buttonText: "Book Slot",
              onPressed: () {},
              buttonGradient: LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection({
    required TextEditingController controller,
    required VoidCallback onApply,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGreyBg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeaderLabel(title: "Coupon Code"),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightGreyBg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter Coupon Code',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: onApply,
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderLabel({
    required String title,
    Color? backgroundColor,
    double topLeftRadius = 16.0,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          bottomRight: const Radius.circular(0),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildWalletInfoTile({
    required String balance,
    required String redeemAmount,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Text(
            'Your wallet balance is ₹$balance, you can redeem ₹$redeemAmount in this order.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillDetails({
    required CartState cartState,
    required CartNotifier cartNotifier,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeaderLabel(title: "Bill Details"),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ...cartState.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: BillRow(
                      label: item.name,
                      value: "₹${item.price * item.quantity}",
                    ),
                  ),
                ),

                const BillRow(label: "Taxes and Fees", value: "₹150"),
                const SizedBox(height: 12),

                BillRow(
                  label: "Coupon Code",
                  value: "₹150 x",
                  isDiscount: true,
                ),

                const SizedBox(height: 16),

                Divider(color: Colors.grey.shade300, thickness: 1),

                const SizedBox(height: 12),

                BillRow(
                  label: "Total",
                  value: cartNotifier.totalPrice.toStringAsFixed(0),
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalSuggestions() {
    return SizedBox(
      height: 310,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => buildServiceCard(
          title: "Bathroom Cleaning",
          price: "500",
          imagePath: AppImages.bathroomCleaning,
        ),
      ),
    );
  }

  Widget buildServiceCard({
    required String title,
    required String price,
    required String imagePath,
    VoidCallback? onAddTap,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,

            child: Image.asset(imagePath, fit: BoxFit.fill),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: onAddTap,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.gradientStart,
                              AppColors.gradientEnd,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
