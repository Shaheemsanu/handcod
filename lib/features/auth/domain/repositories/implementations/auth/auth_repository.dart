import 'dart:developer';
import 'dart:io';

import 'package:handcode_test/shared/providers/supabase_provider/supabase_provider.dart';
import 'package:handcode_test/shared/utils/exceptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:handcode_test/features/auth/auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
IAuthRepository authRepo(Ref ref) => AuthRepository(ref);

class AuthRepository implements IAuthRepository {
  AuthRepository(this.ref) : _supabaseClient = ref.watch(supabaseProvider);
  final Ref ref;
  final SupabaseClient _supabaseClient;
  @override 
  Future<bool> signIn(String email, String password) async {
    try {
      log("signIn-$email --$password");
      AuthResponse response = await _supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      log("response--${response.user}");
      if (response.user != null) {
        return true;
      }
      return false;
    } on PostgrestException catch (e) {
      throw AppException(e.message);
    } on AuthException catch (e) {
      throw AppException(e.message);
    } on SocketException catch (e) {
      throw AppException('Unable to connect to the server: ${e.message}');
    } on FunctionException catch (e) {
      throw AppException.fromFunctionException(e);
    } on Exception catch (e) {
      throw AppException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtp(String email, String otp, String type) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
