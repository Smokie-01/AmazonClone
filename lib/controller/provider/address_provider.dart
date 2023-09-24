import 'package:e_commerce_apk/controller/services/auth_services/user_data_crud_services/user_data_crud_service.dart';
import 'package:e_commerce_apk/model/address_model.dart';
import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  List<AddressModel> allAddress = [];
  AddressModel currentSelectedAddress = AddressModel();
  bool fetchedCurrentSelectedAddres = false;
  bool fetchedAlladdress = false;
  bool addressPresent = false;

  getAllAddress() async {
    allAddress = await UserDataCRUD.getAllAdress();
    fetchedAlladdress = true;
    notifyListeners();
  }

  getCurrentSelectedAddress() async {
    currentSelectedAddress = await UserDataCRUD.getCurrentSelectedAdress();
    addressPresent = await UserDataCRUD.checkUserAddress();
    fetchedCurrentSelectedAddres = true;
    notifyListeners();
  }
}
