import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/utils/colors.dart';
import 'package:flutter/material.dart';

import '../home/home_Screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          width: width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: appBarGradientColor,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
          child: Column(
            children: [
              GridView.builder(
                  physics: const PageScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 18,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyShade1),
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/menu_pics/$index.png",
                            ),
                            fit: BoxFit.fill),
                      ),
                    );
                  }),
              CommonFunction.blankSpace(height * .01, 0),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: width * .02),
                      margin: EdgeInsets.symmetric(vertical: height * .008),
                      height: height * .06,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(
                            color: teal,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(index == 0 ? "Settings" : "Coustmer Service"),
                          const Spacer(),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: black,
                          )
                        ],
                      ),
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
