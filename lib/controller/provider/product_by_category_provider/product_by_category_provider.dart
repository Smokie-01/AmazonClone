import 'package:e_commerce_apk/controller/services/auth_services/user_product_services/user_product_services.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductByCategoryProvider with ChangeNotifier {
  List<ProductModel> products = [];
  bool isProductFteched = false;

  fetchproducts({required String category}) async {
    products = [];
    products =
        await UserProductServices.fetchProductByCategory(category: category);
    notifyListeners();
    isProductFteched = true;
  }
}
