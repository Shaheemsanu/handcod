import 'package:flutter/material.dart';

class BillRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final bool isDiscount;

  const BillRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.isDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? Colors.black
                : isDiscount
                ? Colors.green
                : Colors.black54,
          ),
        ),
      ],
    );
  }
}
