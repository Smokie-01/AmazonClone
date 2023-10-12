import 'package:e_commerce_apk/controller/services/auth_services/user_product_services/user_product_services.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:flutter/material.dart';

class UserProductProvider with ChangeNotifier {
  List<ProductModel> searchProduct = [];

  bool isproductsFetched = false;

  emptySearchProductList() {
    searchProduct = [];
    isproductsFetched = false;
    notifyListeners();
  }

  getSearchProduct({required String productName}) async {
    searchProduct = await UserProductServices.getProducts(productName);
    isproductsFetched = true;
    notifyListeners();
  }
}
