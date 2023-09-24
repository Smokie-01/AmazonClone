// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/controller/provider/product_provider/product_provider.dart';
import 'package:e_commerce_apk/controller/services/product_services/product_services.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:e_commerce_apk/view/seller/add_products_screen/widgets/product_details_common_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/constants.dart';
import '../../../utils/colors.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController manufacturerNameController = TextEditingController();
  TextEditingController countryOfOriginController = TextEditingController();
  TextEditingController productSpecificationsController =
      TextEditingController();

  TextEditingController productPriceController = TextEditingController();
  TextEditingController productIDController = TextEditingController();
  TextEditingController productSellerIDController = TextEditingController();
  String? dropDownValue;
  bool addProductButtonIsPressesd = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        addProductButtonIsPressesd = false;
      });
    });
  }

  onPressed() async {
    if (context.read<SellerProductProvider>().productImages.isNotEmpty) {
      print("Tapped");
      setState(() {
        addProductButtonIsPressesd = true;
      });
      await ProductServices.uploadImagesToFirebaseStorage(
          context.read<SellerProductProvider>().productImages, context);

      List<String> imageURLs =
          context.read<SellerProductProvider>().productImagesURL;

      Uuid uuid = const Uuid();
      String? sellerID = auth.currentUser!.phoneNumber;
      String productID = "$sellerID${uuid.v1().toString()}";
      ProductModel productModel = ProductModel(
        imagesURL: imageURLs,
        name: productNameController.text.trim(),
        category: dropDownValue,
        description: productDescriptionController.text.trim(),
        brandName: brandNameController.text.trim(),
        manufacturerName: manufacturerNameController.text.trim(),
        countryOfOrigin: countryOfOriginController.text.trim(),
        specifications: productDescriptionController.text.trim(),
        price: double.parse(productPriceController.text.trim()),
        productID: productID,
        productSellerID: sellerID,
        inStock: true,
      );
      await ProductServices.addProductToFirebase(
          productModel: productModel, context: context);
    }
    setState(() {
      addProductButtonIsPressesd = false;
    });
    CommonFunction.showSuccessToast(
        context: context, message: "User Address added Succesfully");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.1),
        child: Container(
          padding: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.03,
              bottom: height * 0.012,
              top: height * 0.045),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: appBarGradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage(
                  'assets/images/amazon_black_logo.png',
                ),
                height: height * 0.04,
              ),
              Text(
                " Add Products ",
                style: textTheme.displayMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: Container(
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: width * .03, vertical: height * .03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<SellerProductProvider>(
                builder: (context, productProvider, child) {
                  return Builder(builder: (context) {
                    if (productProvider.productImages.isEmpty) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<SellerProductProvider>()
                              .fetchProductImagesFromGallary(context: context);
                        },
                        child: Container(
                          height: height * .23,
                          width: width,
                          decoration: BoxDecoration(border: Border.all()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: height * .1,
                                Icons.add,
                                color: greyShade3,
                              ),
                              Text("Add Products")
                            ],
                          ),
                        ),
                      );
                    } else {
                      List<File> images =
                          context.read<SellerProductProvider>().productImages;
                      return CarouselSlider(
                        carouselController: CarouselController(),
                        options: CarouselOptions(
                          height: height * 0.23,
                          autoPlay: true,
                          viewportFraction: 1,
                        ),
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(i.path)),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                  });
                },
              ),
              CommonFunction.blankSpace(height * .01, 0),
              ProductCommonTextField(
                  textController: productNameController,
                  hintText: "Prodcut Name",
                  textFieldLabel: "Name"),
              productCategoryDropdown(textTheme, height, width),
              CommonFunction.blankSpace(height * .01, 0),
              ProductCommonTextField(
                  textController: productDescriptionController,
                  hintText: "Descriptioon",
                  textFieldLabel: "Product Description"),
              ProductCommonTextField(
                  textController: brandNameController,
                  hintText: "Brand Name",
                  textFieldLabel: "Brand Name"),
              ProductCommonTextField(
                  textController: manufacturerNameController,
                  hintText: "Manufacturer",
                  textFieldLabel: "Manufacturering Compnay"),
              ProductCommonTextField(
                  textController: countryOfOriginController,
                  hintText: "Country",
                  textFieldLabel: "Country name"),
              ProductCommonTextField(
                  textController: productSpecificationsController,
                  hintText: "Product Specification",
                  textFieldLabel: "Specs"),
              ProductCommonTextField(
                  textController: productPriceController,
                  hintText: "Product Price",
                  textFieldLabel: "price"),
              CommonFunction.blankSpace(height * .02, 0),
              SizedBox(
                width: width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: amber),
                  onPressed: onPressed,
                  child: addProductButtonIsPressesd
                      ? Center(
                          child: CircularProgressIndicator(
                          color: white,
                        ))
                      : Text(
                          "Add Product",
                          style: textTheme.bodyMedium!.copyWith(color: black),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column productCategoryDropdown(
      TextTheme textTheme, double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.06,
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            border: Border.all(
              color: grey,
            ),
          ),
          child: DropdownButton(
            hint: Text("Select Category"),
            value: dropDownValue,
            underline: const SizedBox(),
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: productCategories.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  dropDownValue = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
