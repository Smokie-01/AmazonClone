// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/constants/constants.dart';
import 'package:e_commerce_apk/controller/provider/product_provider/product_provider.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProductServices {
  static Future getImages({required BuildContext context}) async {
    List<File> selectedImages = [];
    final pickedFile = await ImagePicker().pickMultiImage(imageQuality: 70);
    List<XFile> filePick = pickedFile;

    if (filePick.isNotEmpty) {
      for (var i = 0; i < filePick.length; i++) {
        selectedImages.add(File(filePick[i].path));
      }
    } else {
      CommonFunction.showWarningToast(
          context: context, message: 'No Image Selected');
    }
    log('The Images are \n${selectedImages.toList().toString()}');
    return selectedImages;
  }

  static Future uploadImagesToFirebaseStorage(
    List<File> images,
    BuildContext context,
  ) async {
    print("uploadImages to firebase is running");
    final storageRef = FirebaseStorage.instance.ref().child('Product_Images');
    final List<String> imageUrls = [];
    Uuid uuid = const Uuid();
    var sellerUID = auth.currentUser!.phoneNumber;
    for (File image in images) {
      String imageName = '$sellerUID${uuid.v1().toString()}';
      Reference ref = storageRef.child(imageName);
      try {
        await ref.putFile(File(image.path));
        String imageURL = await ref.getDownloadURL();
        imageUrls.add(imageURL);
        log("Images are ready to upload at fire base${imageUrls}");
      } catch (e) {
        print("Error uploading image: $e");
      }
    } // imageUrls now contains the download URLs of all uploaded images
    context
        .read<SellerProductProvider>()
        .updateProductImageUrl(imageURLs: imageUrls, context: context);
  }

  static Future addProductToFirebase(
      // to add users address;
      {
    required ProductModel productModel,
    required BuildContext context,
  }) async {
    try {
      await firestore
          .collection("Products")
          .doc(productModel.productID)
          .set(productModel.toMap())
          .whenComplete(() {
        log(" Product is added succesfulluy");

        context.read<SellerProductProvider>().clearImageList();
        Navigator.pop(context);
      });
    } catch (e) {
      log(e.toString());
      CommonFunction.showErrorToast(context: context, message: e.toString());
    }
  }

  static Future getSellersProduct() async {
    List<ProductModel> sellerProducts = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection("Products")
          .orderBy("uploadedAt", descending: true)
          .where("productSellerID", isEqualTo: auth.currentUser!.phoneNumber)
          .get();

      for (var doc in snapshot.docs) {
        sellerProducts.add(ProductModel.fromMap(doc.data()));
        ProductModel productModel = ProductModel.fromMap(doc.data());
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return sellerProducts;
  }
}
