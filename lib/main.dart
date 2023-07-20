import 'package:e_commerce_apk/utils/theme.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:e_commerce_apk/view/auth_screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        home: OTPScreen(mobileNumber: "+9133445566")
      ),
    );
  }
}


