import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String phoneNumber = '';
  String verificationId = '';
  String otp = '';

  updatePhoneNumber({required String phoneNo}) {
    phoneNumber = phoneNo;
    notifyListeners();
  }

  updateVerificationID({required String verifID}) {
    verificationId = verifID;
    notifyListeners();
  }
}
