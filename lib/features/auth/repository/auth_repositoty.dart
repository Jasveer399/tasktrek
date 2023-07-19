import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  void verifyOtp({
    required BuildContext context,
    required String smsCodeid,
    required String smsCode,
    required bool monuted,
  }) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeid, smsCode: smsCode);
      
      auth.signInWithCredential(credential);
      
  }
}
