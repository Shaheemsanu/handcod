import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> _initGoogleSignIn() async {
    await _googleSignIn.initialize();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _initGoogleSignIn();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication auth = googleUser.authentication;
      log("auth: ${auth.idToken}");
      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken, 
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      log('Google Sign-In Error: $e');
      return null;
    }
  }


  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String errorMessage) onError,
    required VoidCallback onAutoSuccess, 
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        verificationCompleted: (PhoneAuthCredential credential) async {
          log('credential: ${credential.smsCode}');
          await _auth.signInWithCredential(credential);
          onAutoSuccess(); 
        },

        verificationFailed: (FirebaseAuthException e) {
          log('Phone Auth Error: ${e.code}');
          onError(e.message ?? "An unknown error occurred.");
        },

        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },

        codeAutoRetrievalTimeout: (String verificationId) {
        },
        timeout: const Duration(seconds: 60), 
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<UserCredential?> signInWithPhoneCredential(
    PhoneAuthCredential credential,
  ) async {
    log("signInWithPhoneCredential: ${credential.smsCode}");
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
