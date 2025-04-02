import 'package:flutter/material.dart';
import 'package:grocify/screens/cart/cart.dart';
import 'package:grocify/screens/home/home.dart';
import 'package:grocify/screens/profile/user_profile.dart';
import 'package:grocify/screens/search/search_page.dart';
import 'package:grocify/screens/wish_list/wishlist.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  Widget currentScreen = const Home();

  void updateIndex(int index) {
    _currentIndex = index;
    if (_currentIndex == 0) {
      currentScreen = const Home();
    } else if (_currentIndex == 1) {
      currentScreen = const SearchPage();
    } else if (_currentIndex == 2) {
      currentScreen = const Wishlist();
    } else if (_currentIndex == 3) {
      currentScreen = const Cart();
    } else {
      currentScreen = const UserProfile();
    }
    notifyListeners();
  }
}
