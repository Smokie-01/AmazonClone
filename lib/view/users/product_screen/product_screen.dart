// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/constants/constants.dart';
import 'package:e_commerce_apk/controller/services/auth_services/user_product_services/user_product_services.dart';
import 'package:e_commerce_apk/controller/services/product_services/product_services.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:e_commerce_apk/model/user_product_model.dart';
import 'package:e_commerce_apk/utils/colors.dart';
import 'package:e_commerce_apk/view/users/home/home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
// ! Razor Payment Codes
  final razorPay = Razorpay();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymnetSucces);
      razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
  }

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }

  void _handlePaymnetSucces(PaymentSuccessResponse response) async {
    UserProductModel userProductModel = UserProductModel(
      brandName: widget.productModel.brandName,
      category: widget.productModel.brandName,
      countryOfOrigin: widget.productModel.brandName,
      description: widget.productModel.brandName,
      discountPercentage: widget.productModel.discountPercentage,
      discountedPrice: widget.productModel.discountedPrice,
      imagesURL: widget.productModel.imagesURL,
      inStock: true,
      manufacturerName: widget.productModel.brandName,
      name: widget.productModel.brandName,
      price: widget.productModel.price,
      productCount: 1,
      productID: widget.productModel.productID,
      productSellerID: widget.productModel.productSellerID,
      specifications: widget.productModel.specifications,
      time: DateTime.now(),
    );

    await ProductServices.addSalesData(
        context: context,
        userId: auth.currentUser!.phoneNumber!,
        productmodel: userProductModel);

    await UserProductServices.addOrder(
        context: context, productModel: userProductModel);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    try {
      log(response.error.toString());
      log(response.message.toString());
      CommonFunction.showErrorToast(
          context: context, message: "Opps ! Proudct Purshase Failed");
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  excecutePayment() {
    var options = {
      "key": keyID,
      // "amount": widget.productModel.discountedPrice! * 100,
      "amount": 1 * 100,
      "name": widget.productModel.name,
      "description": (widget.productModel.description!.length < 250)
          ? widget.productModel.description!
          : widget.productModel.description!.substring(0, 250),
      "prefill": {
        "contact": auth.currentUser!.phoneNumber,
        "email": "useremail@gmail.com"
      }
    };

    razorPay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    CarouselController carouselController = CarouselController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * .2),
        child: HomePageAppBar(
          width: width,
          height: height,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * .03, vertical: height * .02),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  height: height * 0.2,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                items: widget.productModel.imagesURL!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: white,
                            image: DecorationImage(
                              image: NetworkImage(i),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              CommonFunction.blankSpace(height * .002, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brand : ${widget.productModel.brandName}",
                    style: textTheme.labelMedium!.copyWith(color: teal),
                  ),
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
                        itemSize: width * .04,
                        itemPadding:
                            EdgeInsets.symmetric(horizontal: width * .004),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      CommonFunction.blankSpace(0, width * .005),
                      Text(
                        "(0)",
                        style: textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
              CommonFunction.blankSpace(height * .02, 0),
              Text(
                widget.productModel.name!,
                style: textTheme.bodyMedium!.copyWith(color: black),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "(-${widget.productModel.discountPercentage!} off)",
                      style: textTheme.displayLarge!
                          .copyWith(color: red, fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: "\t\t₹\t${widget.productModel.discountedPrice!}",
                      style: textTheme.displayLarge!
                          .copyWith(color: black, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Text(
                "M.R.P ${widget.productModel.price}",
                style: textTheme.labelMedium!.copyWith(
                    color: grey, decoration: TextDecoration.lineThrough),
              ),
              ElevatedButton(
                onPressed: () async {
                  UserProductModel model = UserProductModel(
                    brandName: widget.productModel.brandName,
                    category: widget.productModel.category,
                    countryOfOrigin: widget.productModel.countryOfOrigin,
                    description: widget.productModel.description,
                    discountPercentage: widget.productModel.discountPercentage,
                    discountedPrice: widget.productModel.discountedPrice,
                    imagesURL: widget.productModel.imagesURL,
                    inStock: widget.productModel.inStock,
                    manufacturerName: widget.productModel.manufacturerName,
                    name: widget.productModel.name,
                    price: widget.productModel.price,
                    productCount: 1,
                    productID: widget.productModel.productID,
                    productSellerID: widget.productModel.productSellerID,
                    specifications: widget.productModel.specifications,
                    time: DateTime.now(),
                  );

                  await UserProductServices.addProductTOCart(
                      context: context, productModel: model);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: Size(width, height * .05)),
                child: Text(
                  "Add to cart",
                  style: textTheme.bodyLarge!.copyWith(color: black),
                ),
              ),
              CommonFunction.blankSpace(height * .0001, 0),
              ElevatedButton(
                onPressed: excecutePayment,
                style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: Size(width, height * .05)),
                child: Text(
                  "Buy Now",
                  style: textTheme.bodyLarge!.copyWith(color: black),
                ),
              ),
              CommonFunction.blankSpace(height * .02, 0),
              CommonFunction.divider(),
              CommonFunction.blankSpace(height * .01, 0),
              const Text("Features"),
              Text(
                widget.productModel.description!,
                style: textTheme.labelMedium!.copyWith(color: black),
              ),
              CommonFunction.blankSpace(height * .02, 0),
              CommonFunction.divider(),
              CommonFunction.blankSpace(height * .01, 0),
              const Text("Specification"),
              Text(
                widget.productModel.description!,
                style: textTheme.labelMedium!.copyWith(color: black),
              ),
              CommonFunction.blankSpace(height * .02, 0),
              CommonFunction.divider(),
              CommonFunction.blankSpace(height * .01, 0),
              const Text("Product Image Gallary"),
              ListView.builder(
                physics: const PageScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.productModel.imagesURL!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: height * .02),
                    color: greyShade2,
                    child: Image.network(
                      widget.productModel.imagesURL![index],
                      fit: BoxFit.scaleDown,
                      height: 200,
                      width: 300,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
