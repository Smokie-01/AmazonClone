import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/constants/constants.dart';
import 'package:e_commerce_apk/controller/services/auth_services/user_data_crud_services/user_data_crud_service.dart';
import 'package:e_commerce_apk/model/user_model.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class UserDataInputScreen extends StatefulWidget {
  const UserDataInputScreen({super.key});

  @override
  State<UserDataInputScreen> createState() => _UserDataSCreenState();
}

class _UserDataSCreenState extends State<UserDataInputScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mobileNumController.text = auth.currentUser!.phoneNumber ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.1),
        child: Container(
          padding: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.03,
              bottom: height * 0.012,
              top: height * 0.045),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: appBarGradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              Image(
                image: const AssetImage(
                  'assets/images/amazon_black_logo.png',
                ),
                height: height * 0.04,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: width * .03, vertical: height * .02),
        child: Column(
          children: [
            SizedBox(
              height: height * .06,
              width: width * 1,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your Name ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                ),
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
            ),
            CommonFunction.blankSpace(height * 0.03, 0),
            SizedBox(
              height: height * .06,
              width: width * 1,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your Mobile Number  ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                ),
                keyboardType: TextInputType.phone,
                controller: mobileNumController,
              ),
            ),
            const Spacer(),
            SizedBox(
                width: width,
                child: CommonAuthButton(
                    title: "Proceed",
                    onPressed: () async {
                      UserModel userModel = UserModel(
                          mobileNum: mobileNumController.text.trim(),
                          name: nameController.text.trim(),
                          userType: "user");
                      await UserDataCRUD.addNewUser(
                          userModel: userModel, context: context);
                    }))
          ],
        ),
      ),
    );
  }
}
