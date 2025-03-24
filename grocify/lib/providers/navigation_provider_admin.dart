import 'package:flutter/material.dart';
import 'package:grocify/Admin/admin_home/admin_home.dart';
import 'package:grocify/Admin/admin_profile/admin_profile.dart';
import 'package:grocify/Admin/grocery_list/grocery_list.dart';

class NavigationProviderAdmin extends ChangeNotifier {
  int _currentIndex = 0;
  Widget currentScreen = const AdminHome();

  void updateIndex(int index) {
    _currentIndex = index;
    if (_currentIndex == 0) {
      currentScreen = const AdminHome();
    } else if (_currentIndex == 1) {
      currentScreen = const GroceryList();
    } else {
      currentScreen = const AdminProfile();
    }
    notifyListeners();
  }
}
