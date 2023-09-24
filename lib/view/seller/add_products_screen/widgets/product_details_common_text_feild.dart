import 'package:e_commerce_apk/constants/common_function.dart';
import 'package:e_commerce_apk/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductCommonTextField extends StatelessWidget {
  const ProductCommonTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.textFieldLabel,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final String textFieldLabel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * .06,
          width: width * 1,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: textFieldLabel,
              labelStyle: TextStyle(color: black),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: grey),
              ),
            ),
            keyboardType: TextInputType.name,
            controller: textController,
          ),
        ),
        CommonFunction.blankSpace(height * .01, 0)
      ],
    );
  }
}
