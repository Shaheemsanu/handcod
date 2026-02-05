import 'package:flutter/material.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/constants/sizes.dart';

class CategoryTabs extends StatelessWidget {
  final List<String> categories;
  final ValueNotifier<String> selectedCategory;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedCategory,
      builder: (_, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: AppColors.lightGreenBg,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: categories.map((cat) {
                final isSelected = cat == value;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => selectedCategory.value = cat,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: isSelected
                          ? BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.gradientStart,
                                  AppColors.gradientEnd,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadius,
                              ),
                            )
                          : null,
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
