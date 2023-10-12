// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/controller/provider/user_product_provider/user_product_provider.dart';
import 'package:e_commerce_apk/controller/services/auth_services/user_product_services/user_product_services.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:e_commerce_apk/model/user_product_model.dart';
import 'package:e_commerce_apk/utils/colors.dart';
import 'package:e_commerce_apk/view/users/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  TextEditingController searchController = TextEditingController();

  getDay(int dayNum) {
    switch (dayNum % 7) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        'Sunday';
    }
  }

  getMonth(int deliveryDate) {
    if (DateTime.now().month == 2) {
      if (deliveryDate > 28) {
        return 'March';
      } else {
        return 'Febuary';
      }
    }
    if (DateTime.now().month == 4 ||
        DateTime.now().month == 6 ||
        DateTime.now().month == 8 ||
        DateTime.now().month == 10 ||
        DateTime.now().month == 12) {
      if ((deliveryDate > 30) && (DateTime.now().month == 12)) {
        return 'January';
      }
      if (deliveryDate > 30) {
        int month = DateTime.now().month + 1;
        switch (month) {
          case 1:
            return 'January';

          case 2:
            return 'February';

          case 3:
            return 'March';

          case 4:
            return 'April';

          case 5:
            return 'May';

          case 6:
            return 'June';

          case 7:
            return 'July';

          case 8:
            return 'August';

          case 9:
            return 'September';

          case 10:
            return 'October';

          case 11:
            return 'November';
          case 12:
            return 'December';
        }
      } else {
        int month = DateTime.now().month;
        switch (month) {
          case 1:
            return 'January';

          case 2:
            return 'February';

          case 3:
            return 'March';

          case 4:
            return 'April';

          case 5:
            return 'May';

          case 6:
            return 'June';

          case 7:
            return 'July';

          case 8:
            return 'August';

          case 9:
            return 'September';

          case 10:
            return 'October';

          case 11:
            return 'November';
          case 12:
            return 'December';
        }
      }
    }
    log(DateTime.now().month.toString());
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProductProvider>().emptySearchProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * .1),
        child: Container(
          padding: EdgeInsets.only(
              left: width * 0.025,
              right: width * 0.03,
              bottom: height * 0.012,
              top: height * 0.05),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: appBarGradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: black,
              ),
              SizedBox(
                width: width * .65,
                height: height * .07,
                child: TextField(
                  onSubmitted: (productName) {
                    context
                        .read<UserProductProvider>()
                        .getSearchProduct(productName: productName);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: width * 0.03),
                      fillColor: white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mic,
                    color: black,
                    size: 20,
                  ))
            ],
          ),
        ),
      ),
      body: Consumer<UserProductProvider>(
        builder: (context, userProductProvider, child) {
          if (userProductProvider.isproductsFetched == false) {
            return const Center(
              child: Text("Search your product here ..."),
            );
          } else if (userProductProvider.searchProduct.isEmpty) {
            return const Center(
              child: Text("Opps ! No Product Found"),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount:
                  context.read<UserProductProvider>().searchProduct.length,
              itemBuilder: (context, index) {
                ProductModel currentProduct =
                    userProductProvider.searchProduct[index];
                if (userProductProvider.isproductsFetched == false) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return InkWell(
                    onTap: () async {
                      await UserProductServices.addRecentlyVisitedProduct(
                          context: context, productModel: currentProduct);
                      Navigator.push(
                        context,
                        PageTransition(
                            child: ProductScreen(productModel: currentProduct),
                            type: PageTransitionType.leftToRight),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: width * .03, vertical: height * .007),
                      height: height * .4,
                      width: width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 200,
                              color: greyShade3,
                              child: Image.network(
                                currentProduct.imagesURL![0],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * .03),
                              child: Column(
                                children: [
                                  Text(
                                    currentProduct.name!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  CommonFunction.blankSpace(height * .004, 0),
                                  Row(
                                    children: [
                                      Text(
                                        "0.0",
                                        style: textTheme.labelMedium,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: width * .07,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: width * .004),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      CommonFunction.blankSpace(
                                          0, width * .005),
                                      Text(
                                        "(0)",
                                        style: textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                  CommonFunction.blankSpace(height * .002, 0),
                                  RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "₹",
                                            style: textTheme.bodyMedium),
                                        TextSpan(
                                            text: currentProduct
                                                .discountedPrice!
                                                .toStringAsFixed(0),
                                            style: textTheme.bodyLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        TextSpan(
                                            text: " \tMRP ",
                                            style: textTheme.labelLarge!
                                                .copyWith(color: grey)),
                                        TextSpan(
                                            text:
                                                currentProduct.price.toString(),
                                            style: textTheme.labelLarge!
                                                .copyWith(
                                                    color: grey,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                        TextSpan(
                                            text:
                                                "\t(${currentProduct.discountPercentage.toString()}% off)",
                                            style:
                                                textTheme.labelLarge!.copyWith(
                                              color: grey,
                                            ))
                                      ],
                                    ),
                                  ),
                                  CommonFunction.blankSpace(height * .01, 0),
                                  Text(
                                    "Save Extra with no cost EMI",
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: grey),
                                  ),
                                  CommonFunction.blankSpace(height * .01, 0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Get it by ",
                                          style: textTheme.labelMedium!
                                              .copyWith(color: grey),
                                        ),
                                        TextSpan(
                                          text: getDay(
                                              DateTime.now().weekday + 3),
                                          style: textTheme.labelMedium!
                                              .copyWith(color: grey),
                                        ),
                                        TextSpan(
                                          text:
                                              " , ${DateTime.now().weekday + 3} ",
                                          style: textTheme.labelMedium!
                                              .copyWith(color: grey),
                                        ),
                                        TextSpan(
                                          text: getMonth(DateTime.now().month),
                                          style: textTheme.labelMedium!
                                              .copyWith(color: grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CommonFunction.blankSpace(height * .01, 0),
                                  Text(
                                    currentProduct.discountedPrice! > 500
                                        ? " Free Delivery by Amazon"
                                        : "Extra Charges Applied",
                                    style: textTheme.bodySmall!
                                        .copyWith(color: grey),
                                  ),
                                  SizedBox(
                                    width: width,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          UserProductModel model =
                                              UserProductModel(
                                            imagesURL: currentProduct.imagesURL,
                                            name: currentProduct.name,
                                            category: currentProduct.category,
                                            description:
                                                currentProduct.description,
                                            brandName: currentProduct.brandName,
                                            manufacturerName:
                                                currentProduct.manufacturerName,
                                            countryOfOrigin:
                                                currentProduct.countryOfOrigin,
                                            specifications:
                                                currentProduct.specifications,
                                            price: currentProduct.price,
                                            discountedPrice:
                                                currentProduct.discountedPrice,
                                            productID: currentProduct.productID,
                                            productSellerID:
                                                currentProduct.productSellerID,
                                            inStock: currentProduct.inStock,
                                            discountPercentage: currentProduct
                                                .discountPercentage,
                                            productCount: 1,
                                            time: DateTime.now(),
                                          );
                                          UserProductServices.addProductTOCart(
                                              context: context,
                                              productModel: model);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            textStyle: textTheme.bodyMedium!
                                                .copyWith(),
                                            backgroundColor: amber),
                                        child: const Text("Add to cart")),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
