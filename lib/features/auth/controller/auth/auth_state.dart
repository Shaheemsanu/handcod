part of 'auth_notifier.dart';

enum AuthStatus { initial, loading, success, error }

extension AuthStatusExtension on AuthStatus {
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() success,
    required R Function() error,
  }) {
    switch (this) {
      case AuthStatus.initial:
        return initial();
      case AuthStatus.loading:
        return loading();
      case AuthStatus.success:
        return success();
      case AuthStatus.error:
        return error();
    }
  }
}

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    @Default('') String error,
  }) = _AuthState;
  factory AuthState.initial() => const AuthState();
  const AuthState._();

  bool get isLoading => status == AuthStatus.loading;
}
