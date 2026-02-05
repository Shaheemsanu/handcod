
import 'package:flutter/material.dart';
import 'package:handcode_test/core/constants/sizes.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;
  final VoidCallback onPressed;

  const CommonButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 12)],
            Text(
              text,
              style: TextStyle(
                color: textColor, 
                fontSize: 16, 
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      ),
    );
  }
}