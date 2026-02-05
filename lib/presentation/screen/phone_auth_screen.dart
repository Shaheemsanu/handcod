import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/common_widgets/custom_button.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/constants/sizes.dart';
import 'package:handcode_test/core/routes/route_names.dart';
import 'package:handcode_test/core/services/auth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _verificationId;
  bool _codeSent = false;
  bool _loading = false;

  void _sendOtp() async {
    setState(() => _loading = true);

    await _authService.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text.trim()}",
      onCodeSent: (verificationId) {
        if (!mounted) return;
        setState(() {
          _verificationId = verificationId;
          _codeSent = true;
          _loading = false;
        });
      },
      onError: (error) {
        if (!mounted) return;
        setState(() => _loading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      },
      onAutoSuccess: () {
        if (!mounted) return;
        GoRouter.of(context).go(RouteNames.home);
      },
    );
  }

  void _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (_verificationId == null || otp.isEmpty) return;

    setState(() => _loading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      final userCred = await _authService.signInWithPhoneCredential(credential);

      if (userCred != null && mounted) {
        GoRouter.of(context).go(RouteNames.home);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid OTP. Please try again.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Phone Authentication",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 40),

              if (!_codeSent) ...[
                TextField(
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Enter Phone Number',
                    prefixText: '+91 ',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                CommonButton(
                  text: _loading ? 'Sending...' : 'Send OTP',
                  backgroundColor: AppColors.primaryGreen,
                  textColor: Colors.white,
                  onPressed: _loading ? () {} : _sendOtp,
                ),
              ] else ...[
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                CommonButton(
                  text: _loading ? 'Verifying...' : 'Verify OTP',
                  backgroundColor: AppColors.primaryGreen,
                  textColor: Colors.white,
                  onPressed: _loading ? () {} : _verifyOtp,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
