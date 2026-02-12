import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hancod_theme/colors.dart';

class CategoryCircle extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isSeeAll;
  final void Function() onTap;

  const CategoryCircle({
    super.key,
    required this.label,
    required this.iconPath,
    this.isSeeAll = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSeeAll ? Colors.white : const Color(0xffF4F7F5),
              border: isSeeAll ? Border.all(color: Colors.grey.shade300) : null,
            ),
            child: !isSeeAll
                ? SvgPicture.asset(iconPath, height: 16, width: 16)
                : Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryGreen,
                    size: 28,
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSeeAll ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const ServiceCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: 140,
      margin: const EdgeInsets.only(right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              height: 155,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
