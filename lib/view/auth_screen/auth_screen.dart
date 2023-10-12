// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_picker/country_picker.dart';
import 'package:e_commerce_apk/controller/services/auth_services/auth_services.dart';
import 'package:e_commerce_apk/view/auth_screen/otp_screen.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/utils/colors.dart';
import 'package:page_transition/page_transition.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Always Declare variable above overide or it wont get updated
  bool inLogin = true;
  String currentCountryCode = "+91";
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: white,
        title: Image(
          image: const AssetImage('assets/images/amazon_logo.png'),
          height: height * 0.04,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: height * .02, vertical: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: textTheme.displaySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                CommonFunction.blankSpace(height * .02, 0),

                Builder(builder: (context) {
                  if (inLogin) {
                    return signInMethod(width, height, textTheme, context);
                  }
                  return createAccount(width, height, textTheme, context);
                }),
                // signInMethod(width, height, textTheme, context),
                // createAccount(width, height, textTheme, context),
                CommonFunction.blankSpace(height * 0.06, 0),
                BottomAuthWidget(
                    width: width, height: height, textTheme: textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container signInMethod(
      double width, double height, TextTheme textTheme, BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.only(bottom: height * .03),
      decoration: BoxDecoration(
        border: Border.all(color: greyShade3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: greyShade2),
            height: height * .07,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inLogin = !inLogin;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .03),
                    height: height * .05,
                    width: width * .05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: red)),
                    child: Icon(
                      size: 12,
                      Icons.circle,
                      color: inLogin ? transparent : secondaryColor,
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "  Create Account. ",
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "New to Amazon?",
                      style: textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.w600)),
                ]))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: height * .02, horizontal: width * .03),
            decoration: BoxDecoration(border: Border.all(color: greyShade3)),
            height: height * .07,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inLogin = inLogin;
                    });
                  },
                  child: Container(
                    height: height * .05,
                    width: width * .05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: red)),
                    child: Icon(
                      size: 12,
                      Icons.circle,
                      color: inLogin ? secondaryColor : transparent,
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "  Sign in. ",
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "Already a customer.",
                      style: textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                ]))
              ],
            ),
          ),
          CommonFunction.blankSpace(height * .01, 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      onSelect: (value) {
                        setState(() {
                          currentCountryCode = '+${value.phoneCode}';
                        });
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: width * .02),
                  height: height * .06,
                  width: width * .16,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(currentCountryCode),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: width * .01),
                child: SizedBox(
                  height: height * .07,
                  width: width * .70,
                  child: TextFormField(
                    decoration: InputDecoration(
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
                    controller: mobileNoController,
                  ),
                ),
              )
            ],
          ),
          CommonFunction.blankSpace(height * 0.02, 0),
          CommonAuthButton(
              title: "Continue",
              onPressed: () {
                AuthServices.receiveOTP(
                    context: context,
                    mobileNo:
                        '$currentCountryCode${mobileNoController.text.trim()}');
                Navigator.push(
                    context,
                    PageTransition(
                        child: OTPScreen(
                            mobileNumber: ' ${mobileNoController.text}'),
                        type: PageTransitionType.leftToRight));
              }),
          CommonFunction.blankSpace(height * 0.02, 0),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "By continue you agree to Amazon' ",
                    style: textTheme.labelMedium),
                TextSpan(
                    text: "conditon of use ",
                    style: textTheme.labelMedium!.copyWith(color: blue)),
                TextSpan(text: "and ", style: textTheme.labelMedium),
                TextSpan(
                    text: "Privacy Notice",
                    style: textTheme.labelMedium!.copyWith(color: blue))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container createAccount(
      double width, double height, TextTheme textTheme, BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: greyShade3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(border: Border.all(color: greyShade3)),
            height: height * .07,
            width: width * 1,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inLogin = !inLogin;
                    });
                  },
                  child: Container(
                    height: height * .05,
                    width: width * .05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: red)),
                    child: Icon(
                      size: 12,
                      Icons.circle,
                      color: inLogin ? transparent : secondaryColor,
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: " Create Account.",
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: " New to Amazon? ",
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                ]))
              ],
            ),
          ),
          CommonFunction.blankSpace(height * .01, 0),
          SizedBox(
            width: width * .85,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                // Customize the appearance of the border
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                // Customize the appearance of the focused border
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: orange),
                ),
                // Customize the appearance of the label text
                labelText: 'Enter your name ',
                labelStyle: const TextStyle(color: secondaryColor),
                // Customize the appearance of the hint text
                hintText: 'John Doe',
                hintStyle: const TextStyle(color: Colors.grey),
                // Customize the appearance of the prefix icon (optional)
                prefixIcon: const Icon(
                  Icons.person,
                  color: secondaryColor,
                ),
                // Customize the appearance of the suffix icon (optional)
              ),
            ),
          ),
          CommonFunction.blankSpace(height * .01, 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      onSelect: (value) {
                        setState(() {
                          currentCountryCode = '+${value.phoneCode}';
                        });
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: width * .03),
                  height: height * .06,
                  width: width * .16,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(currentCountryCode),
                ),
              ),
              SizedBox(
                height: height * .06,
                width: width * .69,
                child: TextFormField(
                  decoration: InputDecoration(
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
                  controller: mobileNoController,
                ),
              )
            ],
          ),
          CommonFunction.blankSpace(height * 0.02, 0),
          CommonAuthButton(
            title: 'Continue',
            onPressed: () {},
          ),
          CommonFunction.blankSpace(height * 0.02, 0),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "By continue you agree to Amazon'\s ",
                    style: textTheme.labelMedium),
                TextSpan(
                    text: "conditon of use ",
                    style: textTheme.labelMedium!.copyWith(color: blue)),
                TextSpan(text: "and ", style: textTheme.labelMedium),
                TextSpan(
                    text: "Privacy Notice",
                    style: textTheme.labelMedium!.copyWith(color: blue))
              ],
            ),
          ),
          CommonFunction.blankSpace(height * .01, 0),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                vertical: height * .02, horizontal: width * .03),
            decoration: BoxDecoration(border: Border.all(color: greyShade3)),
            height: height * .10,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inLogin = true;
                    });
                  },
                  child: Container(
                    height: height * .05,
                    width: width * .05,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: red)),
                    child: Icon(
                      size: 12,
                      Icons.circle,
                      color: inLogin ? secondaryColor : transparent,
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "  Sign in. ",
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "Already a customer.",
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                ]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonAuthButton extends StatelessWidget {
  const CommonAuthButton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width * .68, height * .06), backgroundColor: amber),
      child: Text(
        title,
        style: textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BottomAuthWidget extends StatelessWidget {
  const BottomAuthWidget({
    super.key,
    required this.width,
    required this.height,
    required this.textTheme,
  });

  final double width;
  final double height;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [white, grey, white],
            ),
          ),
        ),
        CommonFunction.blankSpace(height * 0.02, 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Conditon of Use  ",
                style: textTheme.bodySmall!.copyWith(color: blue)),
            Text(" Help", style: textTheme.bodySmall!.copyWith(color: blue)),
            Text(" Privacy Notice ",
                style: textTheme.bodySmall!.copyWith(color: blue))
          ],
        ),
        CommonFunction.blankSpace(height * 0.01, 0),
        Text(
          "@ 1996 - 2023 , Amazon.com , Inc. or its affiliates",
          style: textTheme.labelMedium!.copyWith(color: grey),
        )
      ],
    );
  }
}
