import 'dart:developer';
import 'dart:io';
import 'package:e_commerce_apk/controller/services/product_services/product_services.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:flutter/material.dart';

class SellerProductProvider extends ChangeNotifier {
  List<File> productImages = [];
  List<String> productImagesURL = [];
  List<ProductModel> sellerProducts = [];
  bool isSellerProdcutFetched = false;

  fetchProductImagesFromGallary({required BuildContext context}) async {
    productImages = await ProductServices.getImages(context: context);
    notifyListeners();
  }

  updateProductImageUrl(
      {required List<String> imageURLs, required BuildContext context}) async {
    productImagesURL = imageURLs;
    notifyListeners();
  }

  clearImageList() {
    productImages.clear();
    notifyListeners();
  }

  fetchedSellerProduct() async {
    sellerProducts = await ProductServices.getSellersProduct();
    isSellerProdcutFetched = true;
    notifyListeners();
  }
}
