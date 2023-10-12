import 'package:e_commerce_apk/controller/services/auth_services/user_product_services/user_product_services.dart';
import 'package:flutter/material.dart';

import '../../../model/product_model.dart';

class DealOFTheDayProvider with ChangeNotifier {
  List<ProductModel> deals = [];
  bool isDealsFetched = false;

  fetchTodaysDeal() async {
    deals = [];
    deals = await UserProductServices.fetchDealsOfTheDay();
    isDealsFetched = true;
    notifyListeners();
  }
}
