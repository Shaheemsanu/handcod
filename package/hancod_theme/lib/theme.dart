import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hancod_theme/hancod_theme.dart';

class AppTheme {
  AppTheme._();

  static const double textFieldBorderRadius = 8;
  static final lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Inter',
    colorSchemeSeed: AppColors.black,
    scaffoldBackgroundColor: AppColors.white,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _inputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.textfieldOutline),
      ),
      focusedBorder: _inputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.outlineGrey),
      ),
      errorBorder: _inputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.red),
      ),
      border: _inputBorder,
      fillColor: AppColors.textfieldFill,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: AppText.largeSB.copyWith(color: AppColors.black),
      elevation: 0,
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        surfaceTintColor: WidgetStateProperty.all(AppColors.white),
        backgroundColor: WidgetStateProperty.all(AppColors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        alignment: Alignment.center,
      ),
    ),
  );
  static final darkTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Inter',
    colorSchemeSeed: AppColors.black,
    scaffoldBackgroundColor: AppColors.black,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _inputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.grey),
      ),
      focusedBorder: _inputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.greyish2),
      ),
      errorBorder: _inputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.red),
      ),
      border: _inputBorder,
      fillColor: AppColors.greyish,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: AppText.largeSB.copyWith(color: AppColors.white),
      elevation: 0,
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        surfaceTintColor: WidgetStateProperty.all(AppColors.black),
        backgroundColor: WidgetStateProperty.all(AppColors.black),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        alignment: Alignment.center,
      ),
    ),
  );
  static const _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(textFieldBorderRadius)),
  );

  static Brightness get currentSystemBrightness => PlatformDispatcher.instance.platformBrightness;

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    final brightness = themeMode == ThemeMode.dark
        ? Brightness.dark
        : themeMode == ThemeMode.light
            ? Brightness.light
            : currentSystemBrightness;
    final isDark = brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: isDark ? AppColors.black : AppColors.white,
      ),
    );
  }
}
