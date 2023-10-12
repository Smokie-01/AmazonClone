import 'package:e_commerce_apk/controller/provider/address_provider.dart';
import 'package:e_commerce_apk/controller/provider/auth_provider/auth_provider.dart';
import 'package:e_commerce_apk/controller/provider/deal_of_the_provider/deal_of_the_provider.dart';
import 'package:e_commerce_apk/controller/provider/product_by_category_provider/product_by_category_provider.dart';
import 'package:e_commerce_apk/controller/provider/user_product_provider/user_product_provider.dart';
import 'package:e_commerce_apk/firebase_options.dart';
import 'package:e_commerce_apk/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/provider/product_provider/product_provider.dart';
import 'controller/services/auth_services/sign_In_logic.dart';

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
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<AddressProvider>(
            create: (_) => AddressProvider()),
        ChangeNotifierProvider<SellerProductProvider>(
            create: (_) => SellerProductProvider()),
        ChangeNotifierProvider<UserProductProvider>(
            create: (_) => UserProductProvider()),
        ChangeNotifierProvider<DealOFTheDayProvider>(
          create: (_) => DealOFTheDayProvider(),
        ),
        ChangeNotifierProvider<ProductByCategoryProvider>(
          create: (_) => ProductByCategoryProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        // home: const SellerPresistantNavBar(),
        home: const SignInLogic(),
        // home: const SellerPresistantNavBar(),
      ),
    );
  }
}
