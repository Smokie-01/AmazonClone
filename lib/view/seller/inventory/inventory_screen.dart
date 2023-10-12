import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/controller/provider/product_provider/product_provider.dart';
import 'package:e_commerce_apk/model/product_model.dart';
import 'package:e_commerce_apk/utils/colors.dart';
import 'package:e_commerce_apk/view/seller/add_products_screen/add_products.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SellerProductProvider>().fetchedSellerProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const AddProductScreen(),
                  type: PageTransitionType.leftToRight));
        },
        backgroundColor: amber,
        child: Icon(
          Icons.add,
          color: black,
        ),
      ),
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
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * .03, vertical: height * .02),
        width: width,
        child: Column(
          children: [
            Consumer<SellerProductProvider>(
              builder: (context, sellerProvider, child) {
                if (sellerProvider.isSellerProdcutFetched == false) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                } else if (sellerProvider.sellerProducts.isEmpty) {
                  return const Center(
                    child: Text(" No Products Found !!"),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const PageScrollPhysics(),
                    itemCount: sellerProvider.sellerProducts.length,
                    itemBuilder: (context, index) {
                      ProductModel currentProductModel =
                          sellerProvider.sellerProducts[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: height * .02, horizontal: width * .03),
                        height: height * .35,
                        width: width,
                        decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            CarouselSlider(
                              carouselController: CarouselController(),
                              options: CarouselOptions(
                                height: height * 0.23,
                                autoPlay: true,
                                viewportFraction: 1,
                              ),
                              items: currentProductModel.imagesURL!.map(
                                (i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(i),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentProductModel.name!,
                                        style: textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${currentProductModel.description} , ${currentProductModel.specifications}",
                                        style: textTheme.bodySmall!
                                            .copyWith(color: grey),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Text(
                                          "₹ ${currentProductModel.discountedPrice} "),
                                      Text(
                                        " ₹ ${currentProductModel.price} ",
                                        style: textTheme.bodySmall!.copyWith(
                                            color: grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      Text(
                                        currentProductModel.inStock!
                                            ? "in Stock"
                                            : "Out of Stock",
                                        style: textTheme.bodySmall!.copyWith(
                                            color: currentProductModel.inStock!
                                                ? teal
                                                : red),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
