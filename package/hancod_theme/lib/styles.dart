import 'package:flutter/material.dart';

class AppStyles {
  static final boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 20),
        blurRadius: 27,
        color: Colors.black.withValues(alpha: .05),
      ),
    ],
  );
  static const animationDuration = Duration(milliseconds: 300);
}

class AppTableStyles {
  static const headingRowHeight = 56.0;
  static const dataRowHeight = 76.0;
  static const headingRowColor = Color(0xFFF6F6F6);
  static const dataRowColor = Color(0xFFFDFDFD);
  static const borderColor = Color(0xFFDCDDDC);

  static final decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: borderColor),
  );

  static const border = TableBorder(
    horizontalInside: BorderSide(color: borderColor),
    verticalInside: BorderSide(color: borderColor),
    bottom: BorderSide(color: borderColor),
  );

  static const inputDecoration = InputDecoration(
    border: UnderlineInputBorder(),
    focusedBorder: UnderlineInputBorder(),
    enabledBorder: UnderlineInputBorder(),
    errorBorder: UnderlineInputBorder(),
    disabledBorder: UnderlineInputBorder(),
  );
}
