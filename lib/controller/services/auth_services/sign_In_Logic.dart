import 'package:e_commerce_apk/controller/services/auth_services/auth_services.dart';
import 'package:e_commerce_apk/view/HomeScreen/homescreen.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  checkAuthentication() {
    print("Method Called");
    bool isUserAuthenticated = AuthServices.checkAuth();
    isUserAuthenticated
        ? Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const HomeScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const AuthScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
