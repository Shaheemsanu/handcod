abstract class IAuthRepository {
    Future<bool> signIn(String email, String password);
  Future<void> verifyOtp(String email, String otp, String type);
  Future<void> logout();
}
