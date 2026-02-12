import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppException implements Exception {
  const AppException(this.message, {this.code, this.details});

  factory AppException.fromFunctionException(FunctionException e) {
    if (e.details is String) {
      return AppException(e.details as String);
    }

    final error = e.details['error'] as String?;
    final details = e.details['details'] as String?;

    return AppException(
      error ?? 'An unexpected error occurred',
      details: details,
    );
  }
  final String message;
  final String? details;
  final dynamic code;
  @override
  String toString() =>
      !kDebugMode ? message : message + (details != null ? ' - $details' : '');
}