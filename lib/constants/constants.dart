import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

String keyID = "rzp_test_px2un8wgq16u2H";
String keySecret = "E52UIQayX1yC0n4SXzBFaLL7";

List<String> categories = [
  'Prime',
  'Electronics',
  'Business',
  'Home',
  'miniTV',
  'Mobiles',
  'Fashion',
  'Deals',
  'Travel',
  'Beauty',
  'Furniture',
  'Pharmacy',
  'Movies',
  'Books',
  'Appliances',
  'More',
];

List<String> carouselPictures = [
  '1.png',
  '2.png',
  '3.png',
  '4.png',
  '5.png',
  '6.png',
  '7.png',
  '8.png',
  '9.png',
];

List<String> todaysDeals = [
  'todaysDeal0.png',
  'todaysDeal1.png',
  'todaysDeal2.png',
  'todaysDeal3.png',
];

List<String> headphonesDeals = [
  'bose.png',
  'boat.png',
  'sony.png',
  'onePlus.png',
];

List<String> clothingDealsList = [
  'kurta.png',
  'tops.png',
  't_shirts.png',
  'view_all.png',
];

List<String> productCategories = [
  'Select Category',
  'Electronics',
  'Home',
  'Mobiles',
  'Fashion',
  'Travel',
  'Beauty',
  'Furniture',
  'Pharmacy',
  'Movies',
  'Grocery',
  'Books',
  'More'
];
