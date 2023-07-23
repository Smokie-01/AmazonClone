import 'package:e_commerce_apk/controller/provider/auth_provider/auth_provider.dart';
import 'package:e_commerce_apk/firebase_options.dart';
import 'package:e_commerce_apk/utils/theme.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:e_commerce_apk/view/auth_screen/otp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        home: const AuthScreen(),
      ),
    );
  }
}
