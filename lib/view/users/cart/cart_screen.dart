import 'package:e_commerce_apk/utils/colors.dart';
import 'package:e_commerce_apk/view/users/home/home_Screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/common_function.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width * 1, height * 0.1),
          child: HomePageAppBar(width: width, height: height)),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Subtotal ',
                          style: textTheme.bodyLarge,
                        ),
                        TextSpan(
                          text: '₹ 53133',
                          style: textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonFunction.blankSpace(
                    height * 0.01,
                    0,
                  ),
                  SizedBox(
                    height: height * 0.06,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: teal,
                        ),
                        CommonFunction.blankSpace(
                          0,
                          width * 0.01,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Your Order is eligible for FREE Delivery. ',
                                      style: textTheme.bodySmall!.copyWith(
                                        color: teal,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Select this option at checkout.',
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      backgroundColor: amber,
                      minimumSize: Size(
                        width,
                        height * 0.06,
                      ),
                    ),
                    child: Text(
                      'Proceed to Buy',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  CommonFunction.blankSpace(
                    height * 0.02,
                    0,
                  ),
                  CommonFunction.divider(),
                  CommonFunction.blankSpace(
                    height * 0.02,
                    0,
                  ),
                  ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // UserProductModel currenProduct =
                      //     cartProducts[index];
                      return Container(
                        // height: height * 0.2,
                        width: width,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.01),
                        margin: EdgeInsets.symmetric(
                          vertical: height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        "assets/images/todays_deals/todaysDeal1.png"),
                                    fit: BoxFit.contain,
                                  ),
                                  CommonFunction.blankSpace(
                                    height * 0.01,
                                    0,
                                  ),
                                  Container(
                                    height: height * 0.06,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      border: Border.all(
                                        color: greyShade3,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: InkWell(
                                            onTap: () async {
                                              // if (currenProduct
                                              //         .productCount ==
                                              //     1) {
                                              //   await UsersProductService
                                              //       .removeProductfromCart(
                                              //     productId:
                                              //         currenProduct
                                              //             .productID!,
                                              //     context: context,
                                              //   );
                                              // }
                                              // await UsersProductService
                                              //     .updateCountCartProduct(
                                              //   productId:
                                              //       currenProduct
                                              //           .productID!,
                                              //   newCount: currenProduct
                                              //           .productCount! -
                                              //       1,
                                              //   context: context,
                                              // );
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    color: greyShade3,
                                                  ),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                color: black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Container(
                                                color: white,
                                                alignment: Alignment.center,
                                                child: Text("1"))),
                                        Expanded(
                                          flex: 2,
                                          child: InkWell(
                                            onTap: () async {
                                              // await UsersProductService
                                              //     .updateCountCartProduct(
                                              //   productId:
                                              //       currenProduct
                                              //           .productID!,
                                              //   newCount: currenProduct
                                              //           .productCount! +
                                              //       1,
                                              //   context: context,
                                              // );
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: greyShade3,
                                                  ),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            CommonFunction.blankSpace(
                              0,
                              width * 0.02,
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product",
                                    maxLines: 3,
                                    style: textTheme.bodyMedium,
                                  ),
                                  CommonFunction.blankSpace(
                                    height * 0.01,
                                    0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '₹ 5333',
                                        style: textTheme.displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\tMRP: ₹',
                                        style: textTheme.bodySmall!.copyWith(
                                          color: grey,
                                        ),
                                      ),
                                      Text(
                                        ' 6333',
                                        style: textTheme.bodySmall!.copyWith(
                                            color: grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                  CommonFunction.blankSpace(
                                    height * 0.005,
                                    0,
                                  ),
                                  Text(
                                    "Eligible for free Shipping",
                                    style: textTheme.bodySmall!
                                        .copyWith(color: grey),
                                  ),
                                  CommonFunction.blankSpace(
                                    height * 0.005,
                                    0,
                                  ),
                                  Text(
                                    'In Stock',
                                    style: textTheme.bodySmall!
                                        .copyWith(color: teal),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: white,
                                          side: BorderSide(
                                            color: greyShade3,
                                          ),
                                        ),
                                        child: Text(
                                          'Delete',
                                          style: textTheme.bodySmall,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: white,
                                          side: BorderSide(
                                            color: greyShade3,
                                          ),
                                        ),
                                        child: Text(
                                          'Save for later',
                                          style: textTheme.bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
