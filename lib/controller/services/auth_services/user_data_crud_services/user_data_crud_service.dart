import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/constants/constants.dart';
import 'package:e_commerce_apk/controller/services/auth_services/sign_In_logic.dart';
import 'package:e_commerce_apk/model/address_model.dart';
import 'package:e_commerce_apk/model/user_model.dart';
import 'package:e_commerce_apk/view/users/home/home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class UserDataCRUD {
  static addNewUser(
      {required UserModel userModel, required BuildContext context}) async {
    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.phoneNumber)
          .set(userModel.toMap())
          .whenComplete(() {
        log("User added succesfulluy");
        CommonFunction.showSuccessToast(
            context: context, message: "User Added Succesfully");

        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const SignInLogic(),
                type: PageTransitionType.leftToRight),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static addUserAdress(
      // to add users address;
      {required AddressModel addressModel,
      required BuildContext context,
      required String docID}) async {
    try {
      await firestore
          .collection("Address")
          .doc(auth.currentUser!.phoneNumber)
          .collection("addresses")
          .doc(docID)
          .set(addressModel.toMap())
          .whenComplete(() {
        log("User Address added succesfulluy");
        CommonFunction.showSuccessToast(
            context: context, message: "User Address added Succesfully");
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const HomeScreen(),
                type: PageTransitionType.rightToLeft));
      });
    } catch (e) {
      log(e.toString());
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static Future<bool> checkUser() async {
    bool userPresent = false;

    try {
      var checkNumPresent = await firestore
          .collection("users")
          .where("mobileNum", isEqualTo: auth.currentUser!.phoneNumber)
          .get();
      if (checkNumPresent.size > 0) {
        userPresent = true;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return userPresent;
  }

  static Future<bool> userIsSeller() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('users')
          .doc(auth.currentUser!.phoneNumber)
          .get();
      if (snapshot.exists) {
        UserModel userModel = UserModel.fromMap(snapshot.data()!);
        log('User Type is: ${userModel.userType!}');
        if (userModel.userType != 'user') {
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  static Future<bool> checkUserAddress() async {
    // To check if a user has already added an address.
    bool addressPresent = false;
    try {
      await firestore
          .collection("Address")
          .doc(auth.currentUser!.phoneNumber)
          .collection("addresses")
          .get()
          .then((value) =>
              value.size > 0 ? addressPresent = true : addressPresent = false);
    } on Exception catch (e) {
      log(e.toString());
    }
    return addressPresent;
  }

  static Future<List<AddressModel>> getAllAdress() async {
    List<AddressModel> allAddress = [];
    AddressModel defaultAdress = AddressModel();

    try {
      var snapshot = await firestore
          .collection("Adress")
          .doc(auth.currentUser!.phoneNumber)
          .collection("addresses")
          .get();

      for (var docs in snapshot.docs) {
        allAddress.add(AddressModel.fromMap(docs.data()));
        AddressModel currentAddress = AddressModel.fromMap(docs.data());
        if (currentAddress.isDefault == true) {
          defaultAdress = currentAddress;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return allAddress;
  }

  static getCurrentSelectedAdress() async {
    AddressModel defaultAdress = AddressModel();

    try {
      var snapshot = await firestore
          .collection("Address")
          .doc(auth.currentUser!.phoneNumber)
          .collection("addresses")
          .get();

      for (var docs in snapshot.docs) {
        AddressModel currentAddress = AddressModel.fromMap(docs.data());
        if (currentAddress.isDefault == false) {
          defaultAdress = currentAddress;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return defaultAdress;
  }
}
