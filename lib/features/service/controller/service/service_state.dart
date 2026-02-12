part of 'service_notifier.dart';

enum ServiceStatus { initial, loading, success, error }

extension ServiceStatusExtension on ServiceStatus {
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() success,
    required R Function() error,
  }) {
    switch (this) {
      case ServiceStatus.initial:
        return initial();
      case ServiceStatus.loading:
        return loading();
      case ServiceStatus.success:
        return success();
      case ServiceStatus.error:
        return error();
    }
  }
}

@freezed
abstract class ServiceState with _$ServiceState {
  const factory ServiceState({
    @Default([]) List<Servicemodel> services,
    @Default(ServiceStatus.initial) ServiceStatus status,
    @Default(false) bool isUploading,
    String? error,
  }) = _ServiceState;

  factory ServiceState.initial() => const ServiceState();
}
