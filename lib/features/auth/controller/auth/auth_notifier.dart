import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handcode_test/features/auth/domain/repositories/implementations/auth/auth_repository.dart';
import 'package:handcode_test/features/auth/domain/repositories/interfaces/auth/i_auth_repository.dart';
import 'package:handcode_test/shared/shared.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';
part 'auth_state.dart';

@Riverpod(keepAlive: false)
class AuthNotifier extends _$AuthNotifier {
  final FormGroup form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.email, Validators.required],
    ),
    'password': FormControl<String>(validators: [Validators.required]),
  });
  late IAuthRepository _authRepository;
  @override
  AuthState build() {
    _authRepository = ref.watch(authRepoProvider);
    return AuthState.initial();
  }

  Future<void> signIn() async {
    state = state.copyWith(status: AuthStatus.loading);
    final storage = await ref.watch(sharedPrefsProvider.future);
    form.markAllAsTouched();
    if (!form.valid) return;
    try {
      bool result = await _authRepository.signIn(
        form.value['email'].toString(),
        form.value['password'].toString(),
      );
      log("result: $result");
      if (result) {
        state = state.copyWith(status: AuthStatus.success);
        storage.setBool("isLogin", true);
        Alert.success('Login successful');

        AppRouter.goNamed(AppRouter.home);
      } else {
        state = state.copyWith(status: AuthStatus.error);
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
      Alert.error(e.toString());
      rethrow;
    }
  }
}
