import 'package:ishop_users/assisted_methods/cart_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
final itemsImagesList = [
  "assets/slider/0.jpg",
  "assets/slider/1.jpg",
  "assets/slider/2.jpg",
  "assets/slider/3.jpg",
  "assets/slider/4.jpg",
  "assets/slider/5.jpg",
  "assets/slider/6.jpg",
  "assets/slider/7.jpg",
  "assets/slider/8.jpg",
  "assets/slider/9.jpg",
  "assets/slider/10.jpg",
  "assets/slider/11.jpg",
  "assets/slider/12.jpg",
  "assets/slider/13.jpg",
];

CartMethods cartMethods = CartMethods();
double countStarsRating = 0.0;
String titleStarsRating = "";
String fcmServerToken = "";
