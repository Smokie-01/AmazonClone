import 'dart:developer';

import 'package:e_commerce_apk/controller/provider/auth_provider/auth_provider.dart';
import 'package:e_commerce_apk/controller/services/auth_services/sign_In_Logic.dart';
import 'package:e_commerce_apk/view/auth_screen/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AuthServices {
  static checkAuth() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  static receiveOTP(
      {required BuildContext context, required String mobileNo}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: mobileNo,
          verificationCompleted: (PhoneAuthCredential credential) {
            log(credential.toString());
          },
          verificationFailed: (FirebaseAuthException exception) {
            log(exception.toString());
          },
          codeSent: (String verificationID, int? resentToken) {
            context
                .read<AuthProvider>()
                .updateVerificationID(verifID: verificationID);
            Navigator.push(
              context,
              PageTransition(
                  child: OTPScreen(mobileNumber: mobileNo),
                  type: PageTransitionType.leftToRight),
            );
          },
          codeAutoRetrievalTimeout: (String verificationID) {});
    } catch (e) {
      log(e.toString());
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: context.read<AuthProvider>().verificationId,
          smsCode: otp);
      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
              child: const SignInLogic(),
              type: PageTransitionType.rightToLeft));
    } catch (e) {
      log(e.toString());
    }
  }
}
