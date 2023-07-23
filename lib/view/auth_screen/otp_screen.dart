import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/controller/services/auth_services/auth_services.dart';
import 'package:e_commerce_apk/utils/colors.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({required this.mobileNumber});
  String mobileNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController optController = TextEditingController();
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
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(
              horizontal: width * .02, vertical: height * .03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Authentication Required ",
                style: textTheme.displayMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              CommonFunction.blankSpace(height * .02, 0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: widget.mobileNumber,
                        style: textTheme.displayMedium),
                    TextSpan(
                        text: ' Change',
                        style: textTheme.bodyMedium!.copyWith(color: blue))
                  ],
                ),
              ),
              CommonFunction.blankSpace(height * .02, 0),
              TextField(
                controller: optController,
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
                  // Customize the appearance of the hint text
                  hintText: 'Enter OTP',
                  hintStyle: const TextStyle(color: Colors.grey),
                  // Customize the appearance of the prefix icon (optional)
                  // Customize the appearance of the suffix icon (optional)
                ),
              ),
              CommonFunction.blankSpace(height * .02, 0),
              CommonAuthButton(
                title: "Verify ",
                onPressed: () {
                  AuthServices.verifyOTP(
                      context: context, otp: optController.text);
                },
              ),
              CommonFunction.blankSpace(height * .03, 0),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend OTP",
                  style: textTheme.bodySmall!.copyWith(color: blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
