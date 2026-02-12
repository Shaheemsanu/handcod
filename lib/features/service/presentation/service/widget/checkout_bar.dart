import 'package:flutter/material.dart';
import 'package:hancod_theme/colors.dart';

class CheckOutBar extends StatelessWidget {
  final String summaryText;
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;

  final Gradient? buttonGradient;
  final bool isLoading;

  const CheckOutBar({
    super.key,
    required this.summaryText,
    required this.buttonText,
    required this.onPressed,
    this.buttonGradient,
    this.buttonColor = AppColors.accentOrange,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 18)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              summaryText,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: buttonGradient,
              color: buttonGradient == null ? buttonColor : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: buttonColor,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          buttonText,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.chevron_right, color: Colors.white),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
