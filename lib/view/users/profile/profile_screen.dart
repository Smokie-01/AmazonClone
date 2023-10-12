import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/controller/services/auth_services/user_product_services/user_product_services.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:e_commerce_apk/model/user_product_model.dart';
import 'package:e_commerce_apk/view/users/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              children: [
                Image(
                  image: const AssetImage(
                    'assets/images/amazon_black_logo.png',
                  ),
                  height: height * 0.04,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none,
                    color: black,
                    size: height * 0.035,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: black,
                    size: height * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: height * .002),
            child: Column(
              children: [
                CommonFunction.blankSpace(height * .003, 0),
                UserGreetingsYouScreen(
                    width: width, textTheme: textTheme, height: height),
                CommonFunction.blankSpace(
                  height * 0.01,
                  0,
                ),
                YouGridBtons(width: width, textTheme: textTheme),
                CommonFunction.blankSpace(height * 0.02, 0),
                UsersOrders(width: width, height: height, textTheme: textTheme),
                CommonFunction.blankSpace(
                  height * 0.01,
                  0,
                ),
                CommonFunction.divider(),
                KeepShopping(
                    width: width, height: height, textTheme: textTheme),
                CommonFunction.blankSpace(
                  height * 0.01,
                  0,
                ),
                CommonFunction.divider(),
                BuyAgain(width: width, height: height, textTheme: textTheme),
                CommonFunction.blankSpace(
                  height * 0.02,
                  0,
                ),
              ],
            ),
          ),
        ));
  }
}

class KeepShopping extends StatelessWidget {
  const KeepShopping({
    super.key,
    required this.width,
    required this.height,
    required this.textTheme,
  });

  final double width;
  final double height;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Keep Shopping for',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Browsing history',
                style: textTheme.bodySmall!.copyWith(
                  color: blue,
                ),
              ),
            ],
          ),
          CommonFunction.blankSpace(
            height * 0.02,
            0,
          ),

          StreamBuilder(
              stream: UserProductServices.fetchkeepShopingForProducts(),
              builder: (context, snapshot) {
                List<ProductModel> products = snapshot.data ?? [];
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      height: height * .015,
                      width: width,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(" Opps ! something went wrong"),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No data is present"),
                  );
                } else {
                  return GridView.builder(
                      itemCount: (products.length > 6) ? 6 : products.length,
                      shrinkWrap: true,
                      physics: const PageScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.8),
                      itemBuilder: (context, index) {
                        ProductModel currentProduct = products[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child:
                                    ProductScreen(productModel: currentProduct),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            currentProduct.imagesURL![0])),
                                    border: Border.all(
                                      color: greyShade3,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                              CommonFunction.blankSpace(height * 0.005, 0),
                              Text(
                                currentProduct.name!,
                                maxLines: 2,
                                style: textTheme.labelLarge,
                              )
                            ],
                          ),
                        );
                      });
                }
              }),

          // if (snapshot.hasError) {
          //   return Container(
          //     height: height * 0.15,
          //     width: width,
          //     alignment: Alignment.center,
          //     child: Text(
          //       'Opps! There was an Error',
          //       style: textTheme.bodyMedium,
          //     ),
          //   );
          // } else {
          //   return Container(
          //     height: height * 0.15,
          //     width: width,
          //     alignment: Alignment.center,
          //     child: Text(
          //       'Opps! No Product Found',
          //       style: textTheme.bodyMedium,
          //     ),
          //   );
          // }
        ],
      ),
    );
  }
}

class UsersOrders extends StatelessWidget {
  const UsersOrders({
    super.key,
    required this.width,
    required this.height,
    required this.textTheme,
  });

  final double width;
  final double height;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserProductModel>>(
      stream: UserProductServices.fetchOrders(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Container(
              height: height * .04,
              width: width,
              alignment: Alignment.center,
              child: const Text("Opps !, You Havent ordered anything"),
            );
          }
        } else {
          List<UserProductModel> orders = snapshot.data!;
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.01),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Orders',
                      style: textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See all',
                      style: textTheme.bodySmall!.copyWith(
                        color: blue,
                      ),
                    ),
                  ],
                ),
                CommonFunction.blankSpace(
                  height * 0.02,
                  0,
                ),
                SizedBox(
                  height: height * 0.17,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const PageScrollPhysics(),
                    itemBuilder: (context, index) {
                      // UserProductModel currentProduct = orders[index];
                      return InkWell(
                        onTap: () {
                          // ProductModel product = ProductModel(
                          //     imagesURL: currentProduct.imagesURL,
                          //     name: currentProduct.name,
                          //     category: currentProduct.category,
                          //     description: currentProduct.description,
                          //     brandName: currentProduct.brandName,
                          //     manufacturerName:
                          //         currentProduct.manufacturerName,
                          //     countryOfOrigin:
                          //         currentProduct.countryOfOrigin,
                          //     specifications:
                          //         currentProduct.specifications,
                          //     price: currentProduct.price,
                          //     discountedPrice:
                          //         currentProduct.discountedPrice,
                          //     productID: currentProduct.productID,
                          //     productSellerID:
                          //         currentProduct.productSellerID,
                          //     inStock: currentProduct.inStock,
                          //     uploadedAt: currentProduct.time,
                          //     discountPercentage:
                          //         currentProduct.discountPercentage);

                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     child:
                          //         ProductScreen(productModel: product),
                          //     type: PageTransitionType.rightToLeft,
                          //   ),
                          // );
                        },
                        child: Container(
                          width: width * 0.4,
                          height: height * 0.17,
                          padding: const EdgeInsets.all(5),
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: greyShade3,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: const Image(
                            image: AssetImage(
                                "assets/images/amazon_black_logo.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class BuyAgain extends StatelessWidget {
  const BuyAgain({
    super.key,
    required this.width,
    required this.height,
    required this.textTheme,
  });

  final double width;
  final double height;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Buy Again',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See all',
                style: textTheme.bodySmall!.copyWith(
                  color: blue,
                ),
              ),
            ],
          ),
          CommonFunction.blankSpace(
            height * 0.02,
            0,
          ),
          SizedBox(
              height: height * 0.14,
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: height * 0.14,
                      height: height * 0.14,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/offersNsponcered/onePlus.png")),
                        border: Border.all(
                          color: greyShade3,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

class YouGridBtons extends StatelessWidget {
  const YouGridBtons({
    super.key,
    required this.width,
    required this.textTheme,
  });

  final double width;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // if (index == 0) {
            //   Navigator.push(
            //     context,
            //     PageTransition(
            //       child: const OrdersScreen(),
            //       type: PageTransitionType.rightToLeft,
            //     ),
            //   );
            // }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: grey,
              ),
              borderRadius: BorderRadius.circular(
                50,
              ),
              color: greyShade2,
            ),
            alignment: Alignment.center,
            child: Builder(builder: (context) {
              if (index == 0) {
                return Text(
                  'Your Orders',
                  style: textTheme.bodyMedium,
                );
              }
              if (index == 1) {
                return Text(
                  'Buy Again',
                  style: textTheme.bodyMedium,
                );
              }
              if (index == 2) {
                return Text(
                  'Your Account',
                  style: textTheme.bodyMedium,
                );
              }
              return Text(
                'Your Wish List',
                style: textTheme.bodyMedium,
              );
            }),
          ),
        );
      },
    );
  }
}

class UserGreetingsYouScreen extends StatelessWidget {
  const UserGreetingsYouScreen({
    super.key,
    required this.width,
    required this.textTheme,
    required this.height,
  });

  final double width;
  final TextTheme textTheme;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Hello, ', style: textTheme.bodyLarge),
                TextSpan(
                  text: 'User !',
                  style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          CircleAvatar(
            child: Icon(Icons.person),
            backgroundColor: greyShade3,
            radius: height * 0.025,
          )
        ],
      ),
    );
  }
}
