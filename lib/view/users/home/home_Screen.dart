// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/controller/provider/address_provider.dart';
import 'package:e_commerce_apk/controller/services/auth_services/user_data_crud_services/user_data_crud_service.dart';
import 'package:e_commerce_apk/model/address_model.dart';
import 'package:e_commerce_apk/view/users/address_screen/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController todaysDealsCarouselController = CarouselController();

  checkUserAddress() async {
    bool userAddressPresent = await UserDataCRUD.checkUserAddress();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (userAddressPresent == false) {
      showModalBottomSheet(
          backgroundColor: transparent,
          context: context,
          builder: (context) {
            return Container(
              height: height * 0.3,
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.03),
              width: width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Address',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: height * 0.15,
                    child: ListView.builder(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: AddressScreen(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: width * 0.35,
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greyShade3,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Builder(builder: (context) {
                                if (index == 0) {
                                  return Text(
                                    'Add Address',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: greyShade3),
                                  );
                                }
                                return Text(
                                  'Add Address',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: greyShade3),
                                );
                              }),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          });
    }
  }

  headPhonesName(int index) {
    switch (index) {
      case 0:
        return "Bose";
      case 1:
        return "boAt";
      case 2:
        return "Sony";
      case 3:
        return "OnePlus";
    }
  }

  clothingDeals(int index) {
    switch (index) {
      case 0:
        return 'Kurtas, sarees & more';
      case 1:
        return 'Tops, dresses & more';
      case 2:
        return 'T-Shirt, jeans & more';
      case 3:
        return 'View all';
    }
  }

  @override
  void initState() {
    super.initState();
    //this addPostFramework runs after the build context;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserAddress();
      // This the new way to accces the methods that are present in Provider class;
      context.read<AddressProvider>().getCurrentSelectedAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: Size(width * 1, height * 0.08),
          child: HomePageAppBar(width: width, height: height)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeScreenUserAddressBar(height: height, width: width),
            CommonFunction.divider(),
            const HomeScreenCategoriesList(),
            CommonFunction.blankSpace(height * 0.01, 0),
            CommonFunction.divider(),
            HomeScreenBanner(
              height: height,
            ),
            CommonFunction.blankSpace(height * 0.01, 0),
            TodaysDealHomeScreenWidget(
                todaysDealsCarouselController: todaysDealsCarouselController),
            CommonFunction.blankSpace(height * 0.01, 0),
            otherOfferGridWidget(
                title: "Latest Launches in Headphones",
                textBtnName: "Explore more",
                productPicNamesList: headphonesDeals,
                offerFor: "headphones"),
            SizedBox(
              height: height * 0.35,
              width: width,
              child: const Image(
                image: AssetImage(
                  'assets/images/offersNsponcered/insurance.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            CommonFunction.divider(),
            otherOfferGridWidget(
                title: 'Minimum 70% Off | Top Offers on Clothing',
                textBtnName: 'See all deals',
                productPicNamesList: clothingDealsList,
                offerFor: 'clothing'),
            CommonFunction.divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonFunction.blankSpace(height * 0.01, 0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Text(
                    'Watch Sixer only on miniTV',
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  // height: height * 0.4,
                  width: width,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.01,
                  ),
                  child: const Image(
                    image: AssetImage(
                      'assets/images/offersNsponcered/sixer.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container otherOfferGridWidget(
      {required String title,
      required String textBtnName,
      required List<String> productPicNamesList,
      required String offerFor}) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.01,
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CommonFunction.blankSpace(
              height * 0.01,
              0,
            ),
            GridView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/offersNsponcered/${productPicNamesList[index]}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          offerFor == "headphones"
                              ? headPhonesName(index)
                              : clothingDeals(index),
                          style: textTheme.bodyMedium,
                        )
                      ],
                    ),
                  );
                }),
            TextButton(
              onPressed: () {},
              child: Text(
                textBtnName,
                style: textTheme.bodySmall!.copyWith(
                  color: blue,
                ),
              ),
            ),
          ],
        ));
  }
}

class HomeScreenUserAddressBar extends StatelessWidget {
  const HomeScreenUserAddressBar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        height: height * 0.06,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: addressBarGradientColor,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Consumer<AddressProvider>(
          builder: (context, addressProvider, child) {
            if (addressProvider.fetchedCurrentSelectedAddres == true) {
              AddressModel selectedAddress =
                  addressProvider.currentSelectedAddress;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: black,
                  ),
                  CommonFunction.blankSpace(
                    0,
                    width * 0.02,
                  ),
                  Text(
                    'Deliver to - ${selectedAddress.name},${selectedAddress.town}, ${selectedAddress.state}, ',
                    style: textTheme.labelSmall,
                  )
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: black,
                  ),
                  CommonFunction.blankSpace(
                    0,
                    width * 0.02,
                  ),
                  Text(
                    'Deliver to user - City, Town ',
                    style: textTheme.bodySmall,
                  )
                ],
              );
            }
          },
        ));
  }
}

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     child: const SearchedProductScreen(),
              //     type: PageTransitionType.rightToLeft,
              //   ),
              // );
            },
            child: Container(
              width: width * 0.81,
              height: height * 0.06,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5,
                ),
                border: Border.all(
                  color: grey,
                ),
                color: white,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                    ),
                    child: Text(
                      'Search Amazon.in',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: grey),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.camera_alt_sharp,
                    color: grey,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                // ProductServices.getImages(context: context);
              },
              icon: Icon(
                Icons.mic,
                color: black,
                size: 20,
              ))
        ],
      ),
    );
  }
}

class HomeScreenCategoriesList extends StatelessWidget {
  const HomeScreenCategoriesList();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height * 0.09,
      width: width,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     child:
              //         ProductCategoryScreen(productCategory: categories[index]),
              //     type: PageTransitionType.rightToLeft,
              //   ),
              // );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/categories/${categories[index]}.png',
                    ),
                    height: height * 0.07,
                  ),
                  Text(
                    categories[index],
                    style: textTheme.labelMedium,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeScreenBanner extends StatelessWidget {
  const HomeScreenBanner({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: CarouselController(),
      options: CarouselOptions(
        height: height * 0.23,
        autoPlay: true,
        viewportFraction: 1,
      ),
      items: carouselPictures.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage('assets/images/carousel_slideshow/$i'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class TodaysDealHomeScreenWidget extends StatelessWidget {
  const TodaysDealHomeScreenWidget(
      {required this.todaysDealsCarouselController});
  final CarouselController todaysDealsCarouselController;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '50% - 80% off | Latest deals.',
              style: textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            CommonFunction.blankSpace(height * 0.01, 0),
            CarouselSlider(
              carouselController: todaysDealsCarouselController,
              options: CarouselOptions(
                height: height * 0.2,
                autoPlay: true,
                viewportFraction: 1,
              ),
              items: todaysDeals.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     child:
                        //         ProductScreen(productModel: currentProduct),
                        //     type: PageTransitionType.rightToLeft,
                        //   ),
                        // );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: white,
                          image: DecorationImage(
                            image: AssetImage("assets/images/todays_deals/$i"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            CommonFunction.blankSpace(
              height * 0.01,
              0,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      color: red),
                  child: Text(
                    'Upto 62% Off',
                    style: textTheme.labelMedium!.copyWith(color: white),
                  ),
                ),
                CommonFunction.blankSpace(0, width * 0.03),
                Text(
                  'Deal of the Day',
                  style: textTheme.labelMedium!.copyWith(
                    color: red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            CommonFunction.blankSpace(height * 0.01, 0),
            GridView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      log(index.toString());
                      todaysDealsCarouselController.animateToPage(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: greyShade3,
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/todays_deals/${todaysDeals[index]}"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                }),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all Deals',
                style: textTheme.bodySmall!.copyWith(
                  color: blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
