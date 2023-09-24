// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_apk/controller/services/auth_services/user_data_crud_services/user_data_crud_service.dart';
import 'package:e_commerce_apk/model/address_model.dart';
import 'package:e_commerce_apk/view/auth_screen/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_apk/utils/colors.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/common_function.dart';
import 'widgets/address_screen_text_field.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({
    super.key,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController houseNumbeController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    FirebaseAuth auth = FirebaseAuth.instance;
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
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(
              horizontal: width * .02, vertical: height * .02),
          child: Column(
            children: [
              Text(
                "Enter your Address Details",
                style: textTheme.bodyLarge,
              ),
              CommonFunction.blankSpace(height * .03, 0),
              AdressScreenTextField(
                textFieldLabel: "Enter your name",
                hintText: "Enter your name",
                textController: nameController,
              ),
              AdressScreenTextField(
                textFieldLabel: "Enter your Mobile Number ",
                hintText: "Enter your Mobile Number",
                textController: mobileNumberController,
              ),
              AdressScreenTextField(
                textFieldLabel: "Enter your House Number",
                hintText: "Enter your House Number",
                textController: houseNumbeController,
              ),
              AdressScreenTextField(
                textFieldLabel: "Enter your Area",
                hintText: "Enter your Area",
                textController: areaController,
              ),
              AdressScreenTextField(
                textFieldLabel: "Enter your Land Mark",
                hintText: "Enter your Land Mark",
                textController: landMarkController,
              ),
              AdressScreenTextField(
                textFieldLabel: "Enter your Pincode",
                hintText: "Enter your Pincode",
                textController: pinCodeController,
              ),
              AdressScreenTextField(
                textFieldLabel: "Enter your Town",
                hintText: "Enter your Town",
                textController: townController,
              ),
              AdressScreenTextField(
                textFieldLabel: "Enter your State",
                hintText: "Enter your State",
                textController: stateController,
              ),
              SizedBox(
                width: width,
                child: CommonAuthButton(
                  title: "Add Address",
                  onPressed: () {
                    Uuid uuid = const Uuid();
                    String docID = uuid.v1();
                    AddressModel addressModel = AddressModel(
                        area: areaController.text.trim(),
                        authenticatedMobileNumber:
                            auth.currentUser!.phoneNumber,
                        docID: docID,
                        houseNumber: houseNumbeController.text.trim(),
                        isDefault: false,
                        landMark: landMarkController.text.trim(),
                        mobileNumber: mobileNumberController.text.trim(),
                        name: nameController.text.trim(),
                        pincode: pinCodeController.text.trim(),
                        state: stateController.text.trim(),
                        town: townController.text.trim());
                    UserDataCRUD.addUserAdress(
                        addressModel: addressModel,
                        context: context,
                        docID: docID);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
