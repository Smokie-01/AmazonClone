import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/constants/constants.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:e_commerce_apk/model/user_product_model.dart';
import 'package:flutter/material.dart';

class UserProductServices {
  static Future<List<ProductModel>> getProducts(String productName) async {
    List<ProductModel> sellersProducts = [];
    if (productName.isEmpty) {
      return sellersProducts;
    }
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Products')
          .orderBy('name')
          .startAt([productName.toUpperCase()]).endAt(
              ['${productName.toLowerCase()}\uf8ff']).get();

      for (var element in snapshot.docs) {
        sellersProducts.add(ProductModel.fromMap(element.data()));
      }
      log(sellersProducts.toList().toString());
    } catch (e) {
      log('error Found');
      log(e.toString());
    }
    log(sellersProducts.toList().toString());
    return sellersProducts;
  }

  static Future addProductTOCart(
      {required BuildContext context,
      required UserProductModel productModel}) async {
    try {
      await firestore
          .collection("Cart")
          .doc(auth.currentUser!.phoneNumber)
          .collection("myCart")
          .doc(productModel.productID)
          .set(productModel.toMap())
          .whenComplete(() {
        log("data Added");

        CommonFunction.showSuccessToast(
            context: context, message: "Added to cart");
      });
    } on Exception catch (e) {
      log(e.toString());
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static Future addRecentlyVisitedProduct(
      {required BuildContext context,
      required ProductModel productModel}) async {
    try {
      await firestore
          .collection("Recently_visited_products")
          .doc(auth.currentUser!.phoneNumber)
          .collection("products")
          .where("productID", isEqualTo: productModel.productID)
          .get()
          .then((value) async {
        if (value.size > 1) {
          await firestore
              .collection("Recently_visited_products")
              .doc(auth.currentUser!.phoneNumber)
              .collection("products")
              .doc(productModel.productID)
              .set(productModel.toMap())
              .whenComplete(() {
            log("product added");
          });
        }
      });
    } catch (e) {
      log(e.toString());
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static Stream<List<UserProductModel>> fetchCartProducts() => firestore
      .collection('Cart')
      .doc(auth.currentUser!.phoneNumber)
      .collection('myCart')
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return UserProductModel.fromMap(doc.data());
          }).toList());

  static Future<void> removeProductfromCart({
    required String productId,
    required BuildContext context,
  }) async {
    final collectionRef = firestore
        .collection('Cart')
        .doc(auth.currentUser!.phoneNumber)
        .collection('myCart');

    try {
      final snapshot =
          await collectionRef.where('productID', isEqualTo: productId).get();
      log(snapshot.docs.length.toString());

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs[0].id;
        await collectionRef.doc(docId).delete();
      }
    } catch (e) {
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static Future<void> updateCountCartProduct({
    required String productId,
    required int newCount,
    required BuildContext context,
  }) async {
    final collectionRef = firestore
        .collection('Cart')
        .doc(auth.currentUser!.phoneNumber)
        .collection('myCart');

    try {
      final snapshot =
          await collectionRef.where('productID', isEqualTo: productId).get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs[0].id;
        await collectionRef.doc(docId).update({'productCount': newCount});
      }
    } catch (e) {
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static Stream<List<ProductModel>> fetchkeepShopingForProducts() => firestore
      .collection("Recently_visited_products")
      .doc(auth.currentUser!.phoneNumber)
      .collection("products")
      .orderBy('uploadedAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return ProductModel.fromMap(doc.data());
          }).toList());

  static Future fetchDealsOfTheDay() async {
    List<ProductModel> sellerProducts = [];
    try {
      var snapshot = await firestore
          .collection("Products")
          .orderBy("discountPercentage", descending: true)
          .limit(4)
          .get();

      for (var product in snapshot.docs) {
        sellerProducts.add(ProductModel.fromMap(product.data()));
      }
      log(sellerProducts.toList().toString());
    } catch (e) {
      log(e.toString());
    }
    return sellerProducts;
  }

  static Future fetchProductByCategory({required String category}) async {
    List<ProductModel> sellersProducts = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Products')
          .where("category", isEqualTo: category)
          .get();

      for (var element in snapshot.docs) {
        sellersProducts.add(ProductModel.fromMap(element.data()));
      }
      log(sellersProducts.toList().toString());
    } catch (e) {
      log('error Found');
      log(e.toString());
    }
    log(sellersProducts.toList().toString());
    return sellersProducts;
  }

  static Future addOrder({
    required BuildContext context,
    required UserProductModel productModel,
  }) async {
    try {
      await firestore
          .collection("Orders")
          .doc(auth.currentUser!.phoneNumber)
          .collection("my_orders")
          .doc(productModel.productID)
          .set(productModel.toMap())
          .whenComplete(() {
        log("oreder added ");

        CommonFunction.showSuccessToast(
            context: context, message: "Product order Succesfully");
      });
    } on Exception catch (e) {
      log(e.toString());
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static Stream<List<UserProductModel>> fetchOrders() => firestore
      .collection("Orders")
      .doc(auth.currentUser!.phoneNumber)
      .collection("my_orders")
      .orderBy('time', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return UserProductModel.fromMap(doc.data());
          }).toList());
}
