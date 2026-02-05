import 'package:flutter/material.dart';
import 'package:handcode_test/core/constants/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (onSeeAll != null)
          InkWell(
            onTap: onSeeAll,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'See All',
                  style: TextStyle(color: AppColors.primaryGreen, fontSize: 16),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.primaryGreen,
                  size: 20,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
