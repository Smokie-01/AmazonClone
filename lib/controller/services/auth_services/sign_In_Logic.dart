// ignore_for_file: use_build_context_synchronously
import 'package:e_commerce_apk/controller/services/auth_services/auth_services.dart';
import 'package:e_commerce_apk/controller/services/auth_services/user_data_crud_services/user_data_crud_service.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:e_commerce_apk/view/seller/seller_presistant_nav_bar/seller_presistant_nav_bar.dart';
import 'package:e_commerce_apk/view/users/user_data_screen/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../view/users/user_persistant_nav_bar/user_persistant_nav_bar.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  checkUser() async {
    bool userAlreadyThere = await UserDataCRUD.checkUser();
    // log(userAlreadyThere.toString());
    if (userAlreadyThere) {
      bool isUserSeller = await UserDataCRUD.userIsSeller();
      if (isUserSeller == true) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: SellerPresistantNavBar(),
                type: PageTransitionType.leftToRight));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: UserBottomNavBar(),
                type: PageTransitionType.leftToRight));
      }
    } else {
      Navigator.push(
          context,
          PageTransition(
              child: UserDataInputScreen(),
              type: PageTransitionType.leftToRight));
    }
  }

  checkAuthentication() {
    bool isUserAuthenticated = AuthServices.checkAuth();
    if (isUserAuthenticated) {
      checkUser();
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const AuthScreen(), type: PageTransitionType.rightToLeft),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    //the callback will run after the widget tree has been laid out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
