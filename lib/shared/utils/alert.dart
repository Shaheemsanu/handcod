// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Alert {
  static void show({required String message, ToastificationType type = ToastificationType.info, Duration? duration}) {
    if (message.isEmpty) return;
    toastification.show(
      description: Text(message),
      type: type,
      showProgressBar: false,
      dragToClose: true,
      alignment: Alignment.topCenter,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
    );
  }

  static void success(String message, {Duration? duration}) {
    show(message: message, type: ToastificationType.success, duration: duration);
  }

  static void warning(String message, {Duration? duration}) {
    show(message: message, type: ToastificationType.warning, duration: duration);
  }

  static void info(String message, {Duration? duration}) {
    show(message: message, type: ToastificationType.info, duration: duration);
  }

  static void error(String message, {Duration? duration}) {
    show(message: message, type: ToastificationType.error, duration: duration);
  }
}
